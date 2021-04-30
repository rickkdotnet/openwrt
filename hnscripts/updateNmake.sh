#!/bin/bash
#
# update & make  -  Update source code and continue to make the build

umask 0022
echo "...update main source..."
git pull
[ "$?" -ne 0 ] && echo "Updating the main OpenWrt source code failed." && exit 1
echo "...update feeds..."
./scripts/feeds update -a
[ "$?" -ne 0 ] && echo "Updating the feeds failed." && exit 1
echo "...install feeds..."
./scripts/feeds install -a
echo "...make defconfig..."
make defconfig
#echo "...make menuconfig..."
#make menuconfig
echo "...download new source packages..."
make download
echo "...make the firmware..."
hnscripts/parallelcompile.sh

