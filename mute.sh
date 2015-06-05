#!/bin/bash

echo "-e 1000 -u low (Un)Muted Audio" >> /tmp/notify-script &

amixer -c 1 set Speaker on
amixer -c 1 set Master toggle
