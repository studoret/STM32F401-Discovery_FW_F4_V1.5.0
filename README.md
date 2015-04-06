# STM32F401-Discovery_FW_F4_V1.5.0

STM32CubeF4 archive has been downloaded from :
http://www.st.com/web/en/catalog/tools/PF259243#

#### Requirements :
sudo apt-get install autoconf pkg-config libusb-1.0 git

# Toolchain
mkdir toolchain
cd toolchain
wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q1-update/+download/gcc-arm-none-eabi-4_9-2015q1-20150306-linux.tar.bz2
tar xvf gcc-arm-none-eabi-4_9-2015q1-20150306-linux.tar.bz2

cd ..

# Stlink
git clone https://github.com/texane/stlink.git

cd stlink
./autogen.sh
./configure
make
