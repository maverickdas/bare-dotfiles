#!/bin/bash
x=$(pamixer --get-volume);
if [ $x -gt 145 ]
then
    volnoti-show 100;
else
    pactl set-sink-volume 0 +5%;
    x=$(($x+5))
    echo $x
    volnoti-show $x
fi
