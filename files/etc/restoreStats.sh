#!/bin/sh

/etc/init.d/collectd stop
logger -t "LuCI statistics" collectd stopped, stats being restored
mkdir -p /tmp/rrd/$(uname -n)
cd /tmp/rrd/$(uname -n)
tar x -zvf /etc/backup.stats/stats.tar.gz
/etc/init.d/collectd start
