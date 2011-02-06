#!/bin/sh
# logs the last line. usable via nohup on the server
# FIXME: send RESET or INIT and M2
# FIXME: use absolute path for log-single-line.sh
#
# run command: nohup ./usb-wde1-log-last.sh &
#
socat /dev/ttyUSB0,b9600 STDOUT\
 | ./log-single-line.sh /tmp/usb-wde1-last
