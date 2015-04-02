CC=arm-none-eabi-gcc
AR=arm-none-eabi-ar

# Build artifact location
BUILD_DIR=build

LIB_NAME = libstm32f4_middlewares.a

###########################################

vpath %.c ST/STM32_USB_Device_Library/Class/HID/Src:\
          ST/STM32_USB_Device_Library/Core/Src:\
          ST/STM32_USB_Host_Library/Class/MSC/Src:\
          ST/STM32_USB_Host_Library/Core/Src:\
          Third_Party/FatFs/src:\
          Third_Party/FatFs/src/option:\
          Third_Party/FatFs/src/drivers

CFLAGS  = -g -O2 -Wall
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m4 -march=armv7e-m
CFLAGS += -mfpu=fpv4-sp-d16 -mfloat-abi=$(FLOAT_ABI)
CFLAGS += -ffreestanding -nostdlib

SRCS   =

ifeq ($(USE_USB_DEVICE),1)
  CFLAGS += -IST/STM32_USB_Device_Library/Class/HID/Inc \
            -IST/STM32_USB_Device_Library/Core/Inc
  SRCS   += usbd_hid.c \
            usbd_core.c \
            usbd_ioreq.c usbd_ctlreq.c
endif

ifeq ($(USE_USB_HOST),1)
  CFLAGS += -IST/STM32_USB_Host_Library/Class/MSC/Inc \
            -IST/STM32_USB_Host_Library/Core/Inc

  SRCS   += usbh_core.c usbh_ctlreq.c usbh_ioreq.c usbh_pipes.c
  SRCS   += usbh_msc.c usbh_msc_bot.c usbh_msc_scsi.c
endif

ifeq ($(USE_FATFS),1)
  CFLAGS += -IThird_Party/FatFs/src
  SRCS   += diskio.c ff.c ff_gen_drv.c usbh_diskio.c syscall.c unicode.c
endif

CFLAGS += -I../Drivers/CMSIS/Include \
          -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include \
          -I../Drivers/STM32F4xx_HAL_Driver/Inc


CFLAGS += $(PROJECT_CFLAGS)

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


