#!/bin/env bash
#This file is intended to be used by the sway-bar.

#battery display
battery_percentage() {
    local now=$(cat /sys/class/power_supply/BAT0/charge_now)
    local full=$(cat /sys/class/power_supply/BAT0/charge_full)
    local percentage=$((${now} * 100 / ${full}))
    echo -n "${percentage}"
}
battery_charging() {
    local status=$(cat /sys/class/power_supply/BAT0/status)
    if [ "${status}" = "Charging" ] ; then
	echo -n "+"
    fi
}
print_date() {
    date +'%Y-%m-%d %R:%S' | tr -d "\n"
}
print_status_bar() {
    echo "[$(print_date) $(battery_percentage)$(battery_charging)]"
}

while print_status_bar;
do
    sleep 1;
done
