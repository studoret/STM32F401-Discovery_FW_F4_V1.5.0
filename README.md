# STM32F401-Discovery_FW_F4_V1.5.0

STM32CubeF4 archive has been downloaded from :
http://www.st.com/web/en/catalog/tools/PF259243#

# Requirements :
> sudo apt-get install autoconf pkg-config libusb-1.0 git

## Toolchain
> mkdir toolchain <br />
> cd toolchain <br />
> wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q1-update/+download/gcc-arm-none-eabi-4_9-2015q1-20150306-linux.tar.bz2 <br />
> tar xvf gcc-arm-none-eabi-4_9-2015q1-20150306-linux.tar.bz2 <br />
> cd .. <br />

## Stlink
> git clone https://github.com/texane/stlink.git <br />
> cd stlink <br />
> ./autogen.sh <br />
> ./configure <br />
> make <br />

# Compiling

## Environment varibles 

Edit the STM32Cube_FW_F4_V1.5.0/GNU-ARM/envsetup.sh according to the toolchain and stlink paths <br />
Then do : <br />
> cd STM32Cube_FW_F4_V1.5.0
> source GNU-ARM/envsetup.sh

## Audio_playback_and_record example
> cd Projects/STM32F401-Discovery/Applications/Audio/Audio_playback_and_record <br />
> cd GNU_ARM <br />
> <br />
> \# clean STM32Cube_FW_F4_V1.5.0/Middlewares/build, STM32Cube_FW_F4_V1.5.0/Drivers/build <br \>
> \#     and build directories <br />
> make reallyclean <br />
> <br />
> \# make binaries <br />
> make <br />
> <br />
> \# Flash the board <br />
> make program <br />
