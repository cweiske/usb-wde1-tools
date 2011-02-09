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

curdir="$(dirname "$0")"
if [ "$1" = "--dummy-data" ]; then
    $curdir/../dummy-data-generator.php\
     | $curdir/log-single-line.sh /tmp/usb-wde1-last
else
    if [ ! -r /dev/ttyUSB0 ]; then
        echo "Device /dev/ttyUSB0 is not readable"
        exit 1
    fi

    socat /dev/ttyUSB0,b9600 STDOUT\
     | $curdir/log-single-line.sh /tmp/usb-wde1-last
fi
