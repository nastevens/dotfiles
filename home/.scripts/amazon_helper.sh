#!/bin/sh

xdotool key --window $(xdotool search --limit 1 --all --name 'Amazon Music') $1
