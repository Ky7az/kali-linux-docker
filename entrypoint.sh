#!/bin/bash

service dbus start
service lightdm start

tail -f /dev/null