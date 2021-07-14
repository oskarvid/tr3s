#!/bin/bash

echo "Running announce script $(date)"
echo "$(hostname -I | awk '{print $1}') $(hostname) $(whoami)" > $(hostname).node
scp $(hostname).node oskar@192.168.10.100:/home/oskar/01-workspace/00-temp/tr3s2/nodes/
