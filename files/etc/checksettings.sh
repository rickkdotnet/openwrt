#!/bin/sh
cd /etc/config
for F in *
do
        echo
        echo "===== $F ====="
        uci -c /rom/etc/config export $F >/tmp/$F.default 2>/dev/null
        case $? in 0) ;; *) echo '>> no default in /rom <<' ;; esac
        uci export $F >/tmp/$F.current
        diff -u /tmp/$F.default /tmp/$F.current
        rm -f /tmp/$F.default /tmp/$F.current
done

