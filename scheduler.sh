#!/bin/bash
#set -x

#!/bin/bash

nodes=(nodes/*)

if [[ ! -e queue ]]; then
	echo 0 > queue
fi

setQ () {
	q=$(awk '{ print $1 }' queue)
}

setQ

if [[ $q -lt $((${#nodes[@]}-1)) ]]; then
	echo $(($q+1)) > queue
	setQ
else
	echo "0" > queue
	setQ
fi

#echo $q
username="$(awk '{ print $3 }' ${nodes[$q]})"
hostIP="$(awk '{ print $1 }' ${nodes[$q]})"

echo "username: $username"
echo "hostip: $hostIP"

job=$1

dest=/home/$username/01-workspace/00-temp/tr3s
#echo "here is dest: $dest"
#exit
scratch="job-$(date +%s)"
mkdir -p $scratch
echo "job: $job" > $scratch/job.conf
cp $job $scratch/

scp -r $scratch $username@$hostIP:$dest/scratch/ && \
rm -r $scratch
