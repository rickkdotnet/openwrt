#!/bin/sh
#
# mount & copy  -  Mount the Virtualbox shared folder and copy files to PC

Mounttype=vboxsf
Mountname=PCSHARE
Mountpoint=/media/windows-share
BinDir=bin/targets/ipq806x/generic

echo Check for existing mount of the shared folder $Mountpoint
df | grep $Mountpoint
if [ "$?" -ne 0 ]; then
  echo Mounting $Mountpoint as $Mountname...
  sudo mount -t $Mounttype $Mountname $Mountpoint
  [ "$?" -ne 0 ] && echo "Sudo/mount failed." && exit 1
fi

echo "\nCopy from $PWD ..."
cp $BinDir/*bin $Mountpoint
sleep 2
cp $BinDir/*img $Mountpoint
sleep 2
cp $BinDir/ath10k* $Mountpoint
sleep 1
cp $BinDir/*patch $Mountpoint
sleep 1
cp $BinDir/*sh $Mountpoint
sleep 1
cp $BinDir/*txt $Mountpoint
sleep 1
cp $BinDir/*config.init $Mountpoint
cp $BinDir/*config $Mountpoint
echo done.

