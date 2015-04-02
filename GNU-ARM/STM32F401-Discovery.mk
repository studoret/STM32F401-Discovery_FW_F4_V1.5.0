# Target MCU. STM32F40_41xxx / STM32F427_437xx / STM32F429_439xx / STM32F401xx
# See */CMSIS/Device/ST/STM32F4xx/Include/stm32f4xx.h
MCU=STM32F401xC
DEVICE=STM32F401CC


CC       = arm-none-eabi-gcc
GDB      = arm-none-eabi-gdb
OBJCOPY  = arm-none-eabi-objcopy
OBJDUMP  = arm-none-eabi-objdump
SIZE     = arm-none-eabi-size

DRIVERS_PATH = $(STM_COMMON)/Drivers

MIDDLEWARES_PATH = $(STM_COMMON)/Middlewares

CMSIS_PATH = $(DRIVERS_PATH)/CMSIS

PROJECT_SOURCES_PATH=$(PROJECT_PATH)/Src
PROJECT_INCLUDE_PATH=$(PROJECT_PATH)/Inc

vpath %.c $(PROJECT_SOURCES_PATH)

#Permissible values are: 'soft', 'softfp' and 'hard'.
FLOAT_ABI = softfp

CFLAGS  = -g -Os -Wall 

CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -march=armv7e-m
CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=$(FLOAT_ABI)
CFLAGS += -ffunction-sections -fdata-sections

CFLAGS += -I$(DRIVERS_PATH)/CMSIS/Include
CFLAGS += -I$(DRIVERS_PATH)/CMSIS/Device/ST/STM32F4xx/Include
CFLAGS += -I$(DRIVERS_PATH)/STM32F4xx_HAL_Driver/Inc
CFLAGS += -I$(DRIVERS_PATH)/BSP/STM32F401-Discovery

ifeq ($(USE_FATFS),1)
  CFLAGS += -I$(MIDDLEWARES_PATH)/Third_Party/FatFs/src
  CFLAGS += -I$(MIDDLEWARES_PATH)/Third_Party/FatFs/src/drivers
endif

ifeq ($(USE_USB_HOST),1)
  CFLAGS += -I$(MIDDLEWARES_PATH)/ST/STM32_USB_Host_Library/Core/Inc
  CFLAGS += -I$(MIDDLEWARES_PATH)/ST/STM32_USB_Host_Library/Class/MSC/Inc
endif

ifeq ($(USE_USB_DEVICE),1)
  CFLAGS += -I$(MIDDLEWARES_PATH)/ST/STM32_USB_Device_Library/Core/Inc
  CFLAGS += -I$(MIDDLEWARES_PATH)/ST/STM32_USB_Device_Library/Class/HID/Inc
endif

PROJECT_CFLAGS := -DUSE_STM32F401_DISCO -D$(MCU) -I$(PROJECT_INCLUDE_PATH)

CFLAGS += $(PROJECT_CFLAGS)

LDFLAGS += -Wl,--gc-sections -Wl,-Map=$(BUILD_DIR)/$(PROJECT_NAME).map
LDFLAGS += -L $(DRIVERS_PATH)
LDFLAGS += -L $(MIDDLEWARES_PATH)

ifeq ($(USE_AUDIO_PDM),1)
  LDFLAGS += -L $(MIDDLEWARES_PATH)/ST/STM32_Audio/Addons/PDM
  PROJECT_LIBRARIES := -lPDMFilter_CM4_GCC
endif

OBJS = $(addprefix $(BUILD_DIR)/objs/,$(PROJECT_SOURCES:.c=.o))
DEPS = $(addprefix $(BUILD_DIR)/deps/,$(PROJECT_SOURCES:.c=.d))

# Build artifact location
BUILD_DIR=build

###################################################

# Location of the linker scripts
LINKER_SCRIPT_DIR = $(PROJECT_PATH)/TrueSTUDIO/STM32F401-DISCO

STARTUP_SCRIPT = $(PROJECT_PATH)/TrueSTUDIO/startup_stm32f401xc.s

###################################################

PHONY: all proj program debug clean reallyclean

all: drivers middlewares proj

-include $(DEPS)

drivers: $(DRIVERS_PATH)
	$(MAKE) -C $(DRIVERS_PATH) MCU=$(MCU) PROJECT_CFLAGS="$(PROJECT_CFLAGS)" FLOAT_ABI=$(FLOAT_ABI) USE_AUDIO=$(USE_AUDIO)

middlewares: $(MIDDLEWARES_PATH)
	$(MAKE) -C $(MIDDLEWARES_PATH) MCU=$(MCU) PROJECT_CFLAGS="$(PROJECT_CFLAGS)" FLOAT_ABI=$(FLOAT_ABI) USE_USB_DEVICE=$(USE_USB_DEVICE) USE_USB_HOST=$(USE_USB_HOST) USE_FATFS=$(USE_FATFS)

proj: $(BUILD_DIR) $(BUILD_DIR)/$(PROJECT_NAME).elf

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/deps $(BUILD_DIR)/objs

$(BUILD_DIR)/objs/%.o : %.c $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $< -MMD -MF $(BUILD_DIR)/deps/$(*F).d


$(BUILD_DIR)/$(PROJECT_NAME).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(STARTUP_SCRIPT) -lstm32f4_drivers -lstm32f4_middlewares $(PROJECT_LIBRARIES) -T$(LINKER_SCRIPT_DIR)/$(DEVICE)_FLASH.ld
	$(OBJCOPY) -O ihex $(BUILD_DIR)/$(PROJECT_NAME).elf $(BUILD_DIR)/$(PROJECT_NAME).hex
	$(OBJCOPY) -O binary $(BUILD_DIR)/$(PROJECT_NAME).elf $(BUILD_DIR)/$(PROJECT_NAME).bin
	$(OBJDUMP) -St $(BUILD_DIR)/$(PROJECT_NAME).elf >$(BUILD_DIR)/$(PROJECT_NAME).lst
	$(SIZE) $(BUILD_DIR)/$(PROJECT_NAME).elf

program: all
	@sleep 1
	st-flash write `pwd`/$(BUILD_DIR)/$(PROJECT_NAME).bin 0x08000000

debug: program
	$(GDB) -x extra/gdb_cmds $(PROJECT_NAME).elf

clean:
	find ./ -name '*~' | xargs rm -f	
	rm -rf $(BUILD_DIR)

reallyclean: clean
	$(MAKE) -C $(DRIVERS_PATH) clean
	$(MAKE) -C $(MIDDLEWARES_PATH) clean