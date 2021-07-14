# The Silly Simple Scheduler - TR3S

This little project was done only to explore the workings of a scheduler. The development platform was a 4 node Raspberry Pi cluster. It is only a toy and is not mature for any kind of serious work. It will get very simple work done but it's not optimized, and quite wasteful of resources. Beware of hardcoded paths.

## Ansible
With the ansible code you will set up cron jobs and copy the `tr3s` directory to a hardcoded path.

## Starting a job
The basic syntax is `./scheduler.sh path-to-script.sh`. You can use the `stat-checker.sh` script as an example job. It will gather some basic system information and send it back to the `outputs` directory on the submit node. The `job.sh` script is suitable for testing long jobs.

## How jobs are started
There is a cronjob that runs once per minute which will execute the `starter.sh` script. This script will handle starting jobs if no job is already running.

## How execute nodes are added
There is another cronjob that runs once per minute which will execute the `announcer.sh` script. This script will let the submit node know that it can submit jobs to this execute node.

## Caveats
- Let's assume you have lots of large files to do compute on, they will by default get transferred to the execute node immediately even though they won't get computed on immediately. If you have 99 large files to do compute on, and you have 3 compute nodes, each node will get sent 33 files each. If the compute nodes don't have enough disk space for 33 files you are out of luck. A better solution is to send the input files only when a new job is started, but that's not how it works for now.  
- The cron jobs on the execute nodes run once per minute, the `announcer.sh` script messed with my network so it should probably not run once per minute. And there's probably a smarter solution to announce that a node is available anyways.  
- Only pre-installed software can be used. You need to manually setup your execute nodes to be able to handle whatever compute you want to run on them. It would be cool to be able to set this up in a temporary environment upon job initiation, perhaps the [nix](https://en.wikipedia.org/wiki/Nix_package_manager) package manager could be used for this. Docker is also an option to achieve this.  
- There are lots of hardcoded paths.  
