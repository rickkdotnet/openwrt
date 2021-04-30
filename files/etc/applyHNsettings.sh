#!/bin/sh
cp -f $1 /tmp/HNsettings.cpt
if [ "$?" -eq 0 ] ; then
  ccdecrypt -vf /tmp/HNsettings.cpt
  if [ "$?" -eq 0 ] ; then
    tar -xzv -f /tmp/HNsettings -C /etc
    chmod 744 /etc/dropbear/authorized_keys
  fi
fi

