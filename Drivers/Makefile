CC=arm-none-eabi-gcc
AR=arm-none-eabi-ar

# Build artifact location
BUILD_DIR = build

LIB_NAME = libstm32f4_drivers.a

###########################################

vpath %.c STM32F4xx_HAL_Driver/Src \
          BSP/STM32F401-Discovery \
          BSP/Components/lsm303dlhc \
          BSP/Components/cs43l22 \
          BSP/Components/l3gd20

CFLAGS  = -g -O2 -Wall
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -march=armv7e-m
CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=$(FLOAT_ABI)
#CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=softfp
CFLAGS += -ffreestanding -nostdlib

CFLAGS += -ICMSIS/Include \
          -ICMSIS/Device/ST/STM32F4xx/Include \
          -ISTM32F4xx_HAL_Driver/Inc

#          -I../Middlewares/ST/STM32_Audio/Addons/PDM

CFLAGS += $(PROJECT_CFLAGS)

SRCS = stm32f4xx_hal.c \
       stm32f4xx_hal_cortex.c \
       stm32f4xx_hal_tim.c stm32f4xx_hal_tim_ex.c \
       stm32f4xx_hal_rcc.c stm32f4xx_hal_rcc_ex.c \
       stm32f4xx_hal_dma.c stm32f4xx_hal_dma_ex.c\
       stm32f4xx_hal_gpio.c \
       stm32f4xx_hal_pcd.c stm32f4xx_hal_pcd_ex.c \
       stm32f4xx_hal_spi.c \
       stm32f4xx_hal_i2c.c stm32f4xx_hal_i2c_ex.c \
       stm32f4xx_hal_i2s.c stm32f4xx_hal_i2s_ex.c \
       stm32f4xx_hal_hcd.c \
       stm32f4xx_hal_flash.c stm32f4xx_hal_flash_ex.c \
       stm32f4xx_ll_fmc.c \
       stm32f4xx_ll_usb.c \
       stm32f4xx_hal_pwr.c stm32f4xx_hal_pwr_ex.c

SRCS += stm32f401_discovery.c \
        stm32f401_discovery_accelerometer.c

ifeq ($(USE_AUDIO),1)
  SRCS += stm32f401_discovery_audio.c
endif

ifeq ($(USE_GYROSCOPE),1)
  SRCS += stm32f401_discovery_gyroscope.c l3gd20.c
endif

ifeq ($(USE_ADC),1)
  SRCS += stm32f4xx_hal_adc.c stm32f4xx_hal_adc_ex.c
endif

ifeq ($(USE_RTC),1)
  SRCS += stm32f4xx_hal_rtc.c stm32f4xx_hal_rtc_ex.c
endif

SRCS += lsm303dlhc.c

SRCS += cs43l22.c

OBJS = $(addprefix $(BUILD_DIR)/objs/,$(SRCS:.c=.o))
DEPS = $(addprefix $(BUILD_DIR)/deps/,$(SRCS:.c=.d))

.PHONY: all clean

all: $(LIB_NAME)

-include $(DEPS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/deps $(BUILD_DIR)/objs

$(BUILD_DIR)/objs/%.o : %.c $(BUILD_DIR)
	$(CC) $(CFLAGS) -c -o $@ $< -MMD -MF $(BUILD_DIR)/deps/$(*F).d

$(LIB_NAME): $(OBJS)
	$(AR) -r $@ $(OBJS)

clean:
	rm -f $(OBJS) $(LIB_NAME)
	rm -rf $(BUILD_DIR)


