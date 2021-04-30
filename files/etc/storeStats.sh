#!/bin/sh
/etc/init.d/collectd stop
logger -t "LuCI statistics" Create backup archive
mkdir -p /etc/backup.stats
cd /tmp/rrd/$(uname -n)
tar c -zvf /etc/backup.stats/stats.tar.gz *
cp /etc/backup.stats/stats.tar.gz /etc/backup.stats/stats-$(date +%Y%m%dT%H%M).tar.gz
/etc/init.d/collectd start
