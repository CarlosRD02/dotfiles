#!/usr/bin/env bash
while true; do
    awk '
    /^MemTotal:/ { total = $2 }
    /^MemFree:/ { free = $2 }
    /^Buffers:/ { buffers = $2 }
    /^Cached:/ { cached = $2 }
    /^SReclaimable:/ { sreclaim = $2 }
    /^Shmem:/ { shmem = $2 }
    END {
        used = total - free - buffers - cached - sreclaim + shmem
        printf "%d%%\n", used / total * 100
    }' /proc/meminfo
    sleep 3
done
