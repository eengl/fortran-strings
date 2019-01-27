#!/usr/bin/env bash
set -x

OS_NAME=$(uname)

if [ "$OS_NAME" == "Darwin" ]; then
   DYLD_LIBRARY_PATH=../:$DYLD_LIBRARY_PATH
elif [ "$OS_NAME" == "Linux" ]; then
   LD_LIBRARY_PATH=../:$LD_LIBRARY_PATH
fi

test/test_${1}.x
ret=$?

if [ $ret -eq 0 ]; then
   echo " - Test succeeded."
else
   echo " - Test failed."
fi
exit $ret