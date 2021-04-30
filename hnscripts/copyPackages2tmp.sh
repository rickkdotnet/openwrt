#!/bin/sh
#
# copyPackages2tmp  -  Copy packages to router's /tmp directory

#create new /etc/opkg/customfeeds.conf with base, luci, packages, routing
cat <<EOF >/tmp/customfeeds.conf
src/gz TmpBase file:/tmp/arm_cortex-a15_neon-vfpv4/base
src/gz TmpLuci file:/tmp/arm_cortex-a15_neon-vfpv4/luci
src/gz TmpPackages file:/tmp/arm_cortex-a15_neon-vfpv4/packages
src/gz TmpRouting file:/tmp/arm_cortex-a15_neon-vfpv4/routing
src/gz TmpTarget file:/tmp/target
EOF

#copy packages
echo "Copy packages..."
scp -r bin/packages/arm_cortex-a15_neon-vfpv4 root@192.168.1.1:/tmp/
scp -r bin/targets/ipq806x/generic/packages root@192.168.1.1:/tmp/target

#copy and overwrite /etc/opkg/customfeeds.conf
echo "Copy modified /etc/opkg/customfeeds.conf..."
scp /tmp/customfeeds.conf root@192.168.1.1:/etc/opkg/customfeeds.conf
echo "done."

