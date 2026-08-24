#!/usr/bin/env bash

if pgrep -x screenkey >/dev/null; then
    pkill -x screenkey
else
    screenkey
fi
