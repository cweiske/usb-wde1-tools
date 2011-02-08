#!/bin/sh
# logs the last line. usable via nohup on the server
#
# run this script as follows:
# $ nohup ./usb-wde1-log-last.sh &
#
# License: http://www.gnu.org/licenses/agpl.html AGPL
# Author: Christian Weiske <cweiske@cweiske.de>
#
# FIXME: send RESET or INIT and M2
# FIXME: use absolute path for log-single-line.sh
#
socat /dev/ttyUSB0,b9600 STDOUT\
 | ./log-single-line.sh /tmp/usb-wde1-last
