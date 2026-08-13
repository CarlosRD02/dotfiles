#!/usr/bin/env bash

print_workspaces() {
    local focused desktop json
    focused="$(bspc query -D -d focused --names | head -n1)"
    json="["
    while read -r desktop; do
        if [[ "$desktop" == "$focused" ]]; then
            json+="{\"name\":\"$desktop\",\"active\":true},"
        else
            json+="{\"name\":\"$desktop\",\"active\":false},"
        fi
    done < <(bspc query -D --names)
    json="${json%,}]"
    echo "$json"
}

print_workspaces

bspc subscribe desktop node monitor | while read -r _; do
    print_workspaces
done
