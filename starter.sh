#!/bin/bash

trap die ERR SIGKILL SIGINT

die () {
	rm $slot/busy
}

#shopt -s nullglob
cd /home/pi/01-workspace/00-temp/tr3s2
set -e
set -x

mkdir -p n1
slot=(n1)

jobs=(scratch/job-*)


for dir in ${jobs[@]}; do
	if [[ -e $dir/finished ]]; then
		echo "Deleted $dir"
	fi
done

if [[ -e $slot/busy ]]; then
	date
	echo "found busy file, waiting"
	exit
else
	for dir in ${jobs[@]}; do
#		if [[ -e "$dir/start" ]]; then
#			rm $dir/start
		date
		touch $slot/busy
		runThis=$(awk '{ print $2 }' $dir/job.conf)
		bash $dir/$runThis
		touch $dir/finished
		rm $slot/busy && \
		echo "Job is finished, deleting job directory $dir"
		rm -r $dir
		exit
#		fi
	done
fi
