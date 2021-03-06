#!/bin/sh
# logs the last line. usable via nohup on the server
#
# run this script as follows:
# $ nohup ./usb-wde1-log-last.sh &
#
# Use --dummy-data as parameter to log dummy data only
#
# License: http://www.gnu.org/licenses/agpl.html AGPL
# Author: Christian Weiske <cweiske@cweiske.de>
#
# FIXME: send RESET or INIT and M2

device=/dev/ttyUSB0

if [ ! -d /var/spool/usb-wde1 ]; then
    mkdir /var/spool/usb-wde1
fi

curdir="$(dirname "$0")"
if [ "$1" = "--dummy-data" ]; then
    $curdir/../dummy-data-generator.php\
     | $curdir/log-single-line.sh /var/spool/usb-wde1/usb-wde1-last
else
    if [ ! -r $device ]; then
        echo "Device $device is not readable"
        exit 1
    fi

    #socat breaks something that leads to
    # WRONG VAL, WRONG CMD and FullBuff->Reset
    # errors
    socat $device,b9600,min=1,time=1,brkint=0,icrnl=0,ixoff=1,imaxbel=0,opost=0,isig=0,icanon=0,iexten=0,echo=0,echoe=0,echok=0 STDOUT\
     | $curdir/log-single-line.sh /var/spool/usb-wde1/usb-wde1-last
fi
