#!/bin/sh

niri msg action close-window --id $(niri msg --json pick-window | jq .id)
