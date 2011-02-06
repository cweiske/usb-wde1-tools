#!/bin/sh
# -*- sh -*-

: << =cut

=head1 NAME

usb-wde1 -  Munin plugin to report usb-wde1 temperature and humidity data

=head1 CONFIGURATION

=head2 EXAMPLE CONFIGURATION

 [usb-wde1]
  env.logfile /var/log/usb-wde1.log
  env.host_name House
  env.sensor0 Living room
  env.sensor1 Kitchen

=head1 MAGIC MARKERS

 #%# family=manual
 #%# capabilities=autoconf suggest

=cut

# params:
# - logfile
# - sensor names
# - type (temperature / humidity)
# - hostname

if [ "$1" = "autoconf" ]; then
    if [ -r "$logfile" ]; then
        echo yes
    else
        echo "no (Logfile \"$logfile\" does not exist)"
    fi
    exit 0

elif [ "$1" = "suggest" ]; then
    echo temperature
    echo humidity
    exit 0
fi


#load variables
TYPE=`basename $0 | sed 's/^.*_//g'`


if [ "$1" = "config" ]; then
    if [ "$host_name" != "" ]; then
        echo "host_name $host_name"
    fi
    if [ "$TYPE" = "temperature" ]; then
        echo 'graph_title Temperature'
        echo 'graph_args --base 1000 --lower-limit -30 --upper-limit 60'
        echo 'graph_vlabel Temperature'
    else
        echo 'graph_title Humidity'
        echo 'graph_args --base 1000 --lower-limit 0 --upper-limit 100'
        echo 'graph_vlabel Humidity'
    fi
    echo 'graph_scale no'
    echo 'graph_category sensors'
    #FIXME: warning/critical values
fi