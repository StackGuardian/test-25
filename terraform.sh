#!/bin/bash

# Start time
START_TIME=$(date +%s)

# Run your long-running process here
echo "Starting long-running process..."

# Simulate a long-running process (replace with your actual command)
sleep 2700  # Sleep for approximately 50 minutes (3000 seconds)

# Calculate elapsed time
ELAPSED_TIME=$(( $(date +%s) - START_TIME ))

echo "Long-running process completed in ${ELAPSED_TIME} seconds."
