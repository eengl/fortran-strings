#!/bin/sh

test/test.x
ret=$?
if [ $ret -eq 0 ]; then
   echo " - Test succeeded."
else
   echo " - Test failed."
fi
exit $ret