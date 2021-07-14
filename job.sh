#!/bin/bash

echo "This is the job"
seconds=125
echo "Now I sleep for $seconds seconds"
sleep 125
echo "Rise and shine <3"
echo ""

output=this-is-the-output-$(date +%s)
touch $output

echo "sending back output file"
scp $output oskar@192.168.10.100:/home/oskar/01-workspace/00-temp/tr3s2/outputs/ && \
echo "output files sent"
