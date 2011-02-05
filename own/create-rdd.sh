#!/bin/sh
# data will be collected ~ every 3 minutes (150s)
# after 600s (10min) data are "unknown"
# archives:
# - store avg temperature on every data point for 1day (576*150s)
#
# - store avg temperature every 10 minutes for 1 week (6*24*7 = 1008)
# - store min temperature -"-
# - store max temperature -"-
#
# - store avg temperature every day for 10 years

for i in 1..8
rrdtool create sensor-$1.rrd --step 150 \
 DS:temp:GAUGE:600:-273:5000 \
 DS:humidity:GAUGE:600:0:100 \
 RRA:AVERAGE:0.5:1:576 \
 RRA:AVERAGE:0.5:4:1008 \
 RRA:MIN:0.5:4:1008 \
 RRA:MAX:0.5:4:1008 \
 RRA:AVERAGE:0.5:576:3650
