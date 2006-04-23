#!/bin/bash

# $Id: do_1571_repeat_test.sh,v 1.5 2006-04-23 15:22:10 wmsr Exp $

# Before starting this script, do a:
#
#	d64copy -2 tstimg_rcmp_1571_-ts2.d71 $DRIVENO
#
# not needed anymore, it does it on its own now
#

DRIVETYPE=1571
IMAGEFILENAME=tstimg_rcmp_1571.d71
TESTFILESET=mass

function numargs {
	if [ -e $1 ]
	then
		return $#
	else
		return 0
	fi
	}

./createImage.sh $TESTFILESET $DRIVETYPE do_transfer


OWNDIRNAME=`pwd | tr "/" "\n" | tail -n 1`
for (( i=99 ; i>10 ; i=i-1 ))
do
	numargs "rcmp_"$OWNDIRNAME"_"$i"_1"[0-9][0-9][0-9].log
	if [ 0 -ne $? ] ; then break ; fi
	
	LOGFILEBASENAME=rcmp_"$OWNDIRNAME"_"$i"_
done
echo Logfile base name is: "$LOGFILEBASENAME"

for (( i=1001 ; i<=9999 ; i=i+1 ))
do
	cbmcopy_rcmp.sh $TESTFILESET $DRIVETYPE -ts2 2>&1 | tee $LOGFILEBASENAME$i.log
done
