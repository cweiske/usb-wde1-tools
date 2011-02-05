#!/bin/sh

#split words by semicolons
IFS=";"

#Beispielausgabe USB-WDE1:
# $1;1;;13,8;22,7;22,6;17,8;22,2;21,2;22,9;;59;35;38;49;38;40;35;;;;;;;0
# Doku des Formats in 92030_USB_WDE1_V1.0_UM.pdf bei elv.de verfügbar

#Variablenamen:
# t1-t8: Temperatur in °C der Sensoren 1-8
# f1-f8: Feuchtegrad in % der Sensoren 1-8
# tc:    Temperatur Kombinsensor in °C
# fc:    Feuchtegrad Kombinsensor in %
# wg:    Windgeschwindigkeit in km/h
# ns:    Niederschlag (Wippenschläge)
# regen: Regen 1=ja, 0=nein
while read -r startzeichen zustand zeitstempel\
              t1 t2 t3 t4 t5 t6 t7 t8\
              f1 f2 f3 f4 f5 f6 f7 f8\
              tc fc wg ns regen
do
    echo "line:"
    echo 1: $one , 2: $two, 3: $three, 4: $four
done
echo "done with everything"
