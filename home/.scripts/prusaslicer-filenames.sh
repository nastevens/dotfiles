#!/usr/bin/env bash

SOURCE_PATH="$1"
NEW_NAME=$(tr '[:upper:] ' '[:lower:]-' <<<$SLIC3R_PP_OUTPUT_NAME)
echo "$NEW_NAME" > $SOURCE_PATH.output_name
