#!/usr/bin/env bash

prev_idle=-1
prev_total=-1

while true; do
    read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

    cur_idle=$((idle + iowait))
    cur_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

    if [ "$prev_idle" -ge 0 ]; then
        d_idle=$((cur_idle - prev_idle))
        d_total=$((cur_total - prev_total))
        pct=$((100 * (d_total - d_idle) / d_total))
        echo "${pct}%"
    fi

    prev_idle=$cur_idle
    prev_total=$cur_total
    sleep 2
done
