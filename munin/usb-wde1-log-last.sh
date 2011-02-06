#!/bin/sh
# logs the last line. usable via nohup on the server
# FIXME: send RESET or INIT and M2
socat /dev/ttyUSB0,b9600 STDOUT\
 | ./log-single-line.sh /tmp/usb-wde1-last
