#!/bin/sh
#
# mount & copy  -  Mount the Virtualbox shared folder and copy files to PC

Mountpoint=/Users/rickk/Code/openwrt/builds
BinDir=bin/targets/ipq806x/generic

echo "\nCopy from $PWD ..."
cp $BinDir/*bin $Mountpoint
sleep 2
cp $BinDir/*img $Mountpoint
sleep 2
cp $BinDir/*patch $Mountpoint
sleep 1
cp $BinDir/*sh $Mountpoint
sleep 1
cp $BinDir/*txt $Mountpoint
sleep 1
cp $BinDir/*config.init $Mountpoint
cp $BinDir/*config $Mountpoint
echo done.

