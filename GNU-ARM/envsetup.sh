
export STM32_HOME=/opt/STM32_Discovery

export STLINK=${STM32_HOME}/stlink

export STM_COMMON=${STM32_HOME}/STM32Cube_FW_F4_V1.5.0

export PATH=$PATH:${STM32_HOME}/toolchain/gcc-arm-none-eabi-4_9-2015q1/bin
export PATH=$PATH:${STLINK}

arm-none-eabi-gcc --version
