#!/bin/bash

# This script kills guacd processes that runs longer than 8 hours in the system.

set -e
set -x

# Define the threshold time in seconds (8 hours)
threshold=$((8 * 60 * 60))

# Iterate through all processes
while read -r pid elapsed_time comm; do
  # Calculate the age of the process in seconds
  process_age=$((elapsed_time))

  # Check if the process age is greater than or equal to the threshold
  if [ "$process_age" -ge "$threshold" ]; then
    # Kill the process
    echo "Killing process $pid (started $process_age seconds ago)"
    kill "$pid"
  fi
done < <(ps -eo pid,etimes,command --sort=-etimes|grep guacd |grep -v grep |tail -n +2)

echo "Process cleanup completed."
