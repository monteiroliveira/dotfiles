#!/usr/bin/env bash

sed -n '/START_KEYS/,/END_KEYS/p' ~/.config/qtile/config.py | \
    grep -e '(\[' \
    -e 'desc' \
    -e 'KB_GROUP' | \
    sed -e 's/    \t*//' \
    -e 's/Key//' \
    -e 's/# KB_GROUP /\n/' \
    -e 's/"),#/"\n/' | \
    yad --text-info --back=#282c34 --fore=#46d9ff --geometry=1200x800
