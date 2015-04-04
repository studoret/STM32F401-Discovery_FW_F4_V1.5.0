PROJECT_NAME=STM32F401-Discovery

PROJECT_PATH=$(PWD)/..

# Middleware options
USE_USB_DEVICE = 0
USE_USB_HOST   = 0
USE_FATFS      = 0
USE_AUDIO_PDM  = 1

# Drivers options
USE_AUDIO      = 1
USE_ADC        = 0
USE_GYROSCOPE  = 1
USE_RTC        = 0

PROJECT_SOURCES := main.c\
                   stm32f4xx_it.c\
                   system_stm32f4xx.c \
                   audio_play.c  audio_record.c mems.c

# Use to set additional action in the program makefile rule
PROJECT_POST_PROGRAM := st-flash write ${STM_COMMON}/Utilities/Media/Audio/art_of_gard_128K.bin 0x08080000

include $(STM_COMMON)/GNU-ARM/STM32F401-Discovery.mk
