PROJECT_NAME=STM32F401-DISCO

PROJECT_PATH=$(PWD)/..

USE_USB_DEVICE = 1
USE_USB_HOST   = 0
USE_FATFS      = 0
USE_AUDIO_PDM  = 0
USE_AUDIO      = 0

PROJECT_SOURCES := main.c\
                   stm32f4xx_hal_msp.c\
                   stm32f4xx_it.c\
                   system_stm32f4xx.c\
                   usbd_conf.c\
                   usbd_desc.c

PROJECT_SOURCES += syscalls.c

include $(STM_COMMON)/GNU-ARM/STM32F401-Discovery.mk