#!/bin/bash
#
# parallelcompile  -  Compile using multiple threads

echo "...create version info file..."
hnscripts/timestampVersion.sh
echo "...make world..."
mkdir -p logs
make -j 5 V=s 2>&1 | tee logs/build.log | grep -i -E "^make.*(error|[12345]...Entering dir)|^warning"
[ ${PIPESTATUS[0]} -ne 0 ] && exit 1
echo -n "...create build info: "
hnscripts/createbuildinfo.sh
echo done.

