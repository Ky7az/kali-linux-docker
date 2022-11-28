#!/bin/bash

sed -i "s/xserver-display-number=0/xserver-display-number=$(echo $DISPLAY | cut -f 2 -d ':' | cut -f 1 -d '.')/g" /etc/lightdm/lightdm.conf.d/lightdm.conf

service dbus start
service lightdm start
# service ssh start

tail -f /dev/null