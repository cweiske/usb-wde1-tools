#!/bin/sh
# -*- sh -*-

: << =cut

=head1 NAME

usb-wde1 -  Munin plugin to report usb-wde1 temperature and humidity data

=head1 CONFIGURATION

=head2 EXAMPLE CONFIGURATION

 [usb-wde1]
  env.logfile /var/log/usb-wde1.log
  env.sensor0 Living room
  env.sensor1 Kitchen

=head1 MAGIC MARKERS

 #%# family=manual
 #%# capabilities=autoconf suggest

=cut

# suggest, config
# params:
# - logfile
# - sensor names
# - type (temperature / humidity

if [ "$1" = "autoconf" ]; then
    if [ -r "$logfile" ]; then
        echo yes
    else
        echo "no (Logfile \"$logfile\" does not exist)"
    fi
    exit 0
fi

if [ "$1" = "suggest" ]; then
    echo temperature
    echo humidity
    exit 0
fi
