#!/bin/sh
#Logs a single line into the log file passed as script parameter


#split words by semicolons
IFS=";"

#Beispielausgabe USB-WDE1:
# $1;1;;13,8;22,7;22,6;17,8;22,2;21,2;22,9;;59;35;38;49;38;40;35;;;;;;;0
# Doku des Formats in 92030_USB_WDE1_V1.0_UM.pdf bei elv.de verfügbar
# Format ist "Logview openformat"
# http://www.logview.info/cms/d_formatbeschreibung.phtml

while read -r line
do
    timestamp = `date +%s`
    echo $line sed "s/$1;1;;/$1;1;$timestamp;/"
done
echo "done with everything"
