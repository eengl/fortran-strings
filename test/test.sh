#!/usr/bin/env bash
#set -x

OS_NAME=$(uname)

BUILD_DIR=$PWD
TEST_DIR=$BUILD_DIR/test

cd $TEST_DIR

if [ "$OS_NAME" == "Darwin" ]; then
   export DYLD_LIBRARY_PATH="$BUILD_DIR:$DYLD_LIBRARY_PATH"
elif [ "$OS_NAME" == "Linux" ]; then
   export LD_LIBRARY_PATH="$BUILD_DIR:$LD_LIBRARY_PATH"
fi

./test_${1}.x
ret=$?

if [ $ret -eq 0 ]; then
   echo " - Test succeeded."
else
   echo " - Test failed."
fi
exit $ret