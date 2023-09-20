#!/bin/bash

# This script kills processes that runs longer than 12 hours in the system.

set -e
set -x

# Define the threshold time in seconds (12 hours)
threshold=$((12 * 60 * 60))

# Get the current timestamp in seconds
# current_time=$(date +%s)

# Iterate through all processes
while read -r pid elpased_time; do
  if [ "$pid" == "1" ]; then
    continue
  fi

  # Calculate the age of the process in seconds
  process_age=$((elapsed_time))

  # Check if the process age is greater than or equal to the threshold
  if [ "$process_age" -ge "$threshold" ]; then
    # Kill the process
    echo "Killing process $pid (started $process_age seconds ago)"
    kill "$pid"
  fi
done < <(ps -eo pid=,etime=)

echo "Process cleanup completed."
