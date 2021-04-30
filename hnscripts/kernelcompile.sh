#!/bin/bash
#
# kernelcompile  -  Clean & compile kernel using a single thread. No update.

echo "...make kernel..."
make target/linux/clean
mkdir -p logs
make target/linux/compile V=s 2>&1 | tee logs/build.log | grep -i -E "^make.*(error|[12345]...Entering dir)"

