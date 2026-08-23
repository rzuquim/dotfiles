#!/usr/bin/env bash

if pgrep -x screenkey >/dev/null; then
    pkill -x screenkey
else
    screenkey \
        -p fixed \
        -g '20%x9%-2%-20%' &
fi
