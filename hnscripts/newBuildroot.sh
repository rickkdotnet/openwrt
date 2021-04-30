#!/bin/sh
#
# newBuildroot.sh
#
# Creates the build environment with the current directory as the root
# To avoid problems with long paths, something like /Openwrt is preferable
#
# Script creates subdir for trunk or the release branch, and dl for downloads
# Creates main source repository and luci, packages & routing feeds

### Target definitions
TARGET=owrt2102
GITREPO="-b openwrt-21.02 --single-branch https://git.openwrt.org/openwrt/openwrt.git"

## Current version
FILESTAMP=R7800-owrt2102-r15840-7a0cd1ede4-20210220-1126

### Prerequisites for buildroot
sudo apt-get install build-essential subversion libncurses5-dev zlib1g-dev
sudo apt-get install gawk gcc-multilib flex git gettext libssl-dev
sudo apt-get install python3-distutils

### Prerequisites for being able to send patches to openwrt-devel
sudo apt-get install git-email

### Newly patched Ubuntu may not yet have the correct kernel headers.
# sudo apt-get install linux-headers-$(uname -r)

### set the preferred umask (allowed: 0000-0022)
umask 0022

### download directory (outside main directory to protect from make distclean)
mkdir -p dl

### main directory
mkdir -p $TARGET

### checkout/clone and change to directory
git clone $GITREPO $TARGET
cd $TARGET

### create symlink to dl (after git clone)
ln -s ../dl dl

### patch main source first to set feeds correctly
### update the feeds, apply patches to feeds
### re-create index to find new packages, finally install
patch -p1 -i ../$FILESTAMP-main.patch
scripts/feeds update -a
(cd feeds/luci;     patch -p1 -i ../../../$FILESTAMP-luci.patch)
(cd feeds/packages; patch -p1 -i ../../../$FILESTAMP-packages.patch)
#(cd feeds/routing;  patch -p1 -i ../../../$FILESTAMP-routing.patch)
scripts/feeds update -i
scripts/feeds install -a

### chmod known script files executable
chmod -f 755 files/etc/*.sh
chmod -f 755 files/etc/rc.button/*

### chmod buildscripts executable
chmod -f 755 hnscripts/*.sh

### add created/modified files in main repo to version control
git add -f files
git add -A

### add created/modified files in feeds to version control
(cd feeds/luci;     git add -A)
(cd feeds/packages; git add -A)
#(cd feeds/routing;  git add -A)

### initialise .config
cp .config.init .config

