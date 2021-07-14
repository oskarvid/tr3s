#!/bin/bash

rm $(hostname)-status.log

logger () {
	status=$(hostname)-status.log
	echo $1 >> $status
	${2} >> $status
	echo "" >> $status
}

logger "hostname:" "hostname"
logger "IP:" "echo $(hostname -I | awk '{print $1}')"
logger "Disk:" "df -h"
logger "RAM" "echo $(free -h | awk 'FNR == 2{ print $2 }')"

echo "sending back output file"
scp $status oskar@192.168.10.100:/home/oskar/01-workspace/00-temp/tr3s2/outputs/ && \
echo "output files sent"
