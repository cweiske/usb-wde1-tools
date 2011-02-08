#!/bin/sh
# Logs a single line into the log file passed as script parameter
#  and adds timestamp to the logview openformat lines
#
# License: http://www.gnu.org/licenses/agpl.html AGPL
# Author: Christian Weiske <cweiske@cweiske.de>

file="$1"
if [ "x$file" = "x" ]; then
    echo Please pass a file name to log the line into
    exit 1
fi

# $1;1;;13,8;22,7;22,6;17,8;22,2;21,2;22,9;;59;35;38;49;38;40;35;;;;;;;0
while read -r line
do
    beginning=`echo "$line"|cut -b 1-3`
    if [ "$beginning" = '$1;' ]; then
        timestamp=`date +%s`
        echo $line|sed "s/\$1;1;;/\$1;1;$timestamp;/" > "$file"
    fi
done
