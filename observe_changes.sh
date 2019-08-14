#!/usr/bin/env bash

echo "Started observing of dart files changes inside /lib"

while true
do
    find lib/ -name '*.dart' | \
        entr -d -p ./hot_reload.sh /_
done
