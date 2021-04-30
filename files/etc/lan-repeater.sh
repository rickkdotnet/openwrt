#!/bin/sh
uci set system.@system[0].hostname=router2
uci set network.lan.ipaddr=192.168.1.2
uci set network.lan.ip6ifaceid='::2'
uci set network.lan.gateway=192.168.1.1
uci set network.lan.dns=192.168.1.1
uci set network.henet.auto=0
uci set network.lan6=interface
uci set network.lan6.ifname=@lan
uci set network.lan6.proto=dhcpv6
uci set network.lan6.reqprefix=no
uci set wireless.@wifi-device[0].channel=48
uci set wireless.@wifi-device[1].channel=9
uci set dhcp.lan.ignore=1
uci set dhcp.lan.force=0
uci delete dhcp.lan.dhcpv6
uci delete dhcp.lan.ra
uci delete dhcp.lan.ndp
uci set upnpd.config.enable_natpmp=0
uci set upnpd.config.enable_upnp=0
uci commit dhcp
uci commit network
uci commit wireless
uci commit system
uci commit upnpd
/etc/init.d/dnsmasq disable
/etc/init.d/miniupnpd disable

