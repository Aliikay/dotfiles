#!/bin/sh

# Get display information from compositor
scales=$(niri msg outputs | grep "Scale: ")
echo $scales

# Figure out how many displays there were
linecount=$(echo $scales | wc -l)
echo $linecount

# If i have 1 display then I am laptop, scale to 1.3
# If there are 2 or more displays then I am desktop, scale to 1
if [ "$linecount" == "1" ]; then
    xwayland-satellite -forcedesktopscaling=1.3
else
    xwayland-satellite -forcedesktopscaling=1
fi
