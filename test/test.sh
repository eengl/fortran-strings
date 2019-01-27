#!/bin/sh

if [ "$(uname)" == "Darwin" -a "$1" == "shared" ]; then
   DYLD_LIBRARY_PATH=../:$DYLD_LIBRARY_PATH
elif [ "$(uname)" == "Linux" -a "$1" == "shared" ]; then
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