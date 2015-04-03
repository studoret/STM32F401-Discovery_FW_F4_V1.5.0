PROJECT_NAME=STM32F401-DISCO

PROJECT_PATH=$(PWD)/..

USE_USB_DEVICE = 0
USE_USB_HOST   = 1
USE_FATFS      = 1
USE_AUDIO_PDM  = 1
USE_AUDIO      = 1

PROJECT_SOURCES := main.c\
                   stm32f4xx_it.c\
                   system_stm32f4xx.c\
                   usbh_conf.c\
                   waveplayer.c\
                   waverecorder.c

include $(STM_COMMON)/GNU-ARM/STM32F401-Discovery.mk