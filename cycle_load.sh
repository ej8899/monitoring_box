#!/bin/sh

#
# randomize CPU load on our monitoring box - initial basic stress test to check reliability prior to deployment as well as to test monitor accuracy and update timing
#


# Define the number of CPU cores
NUM_CORES=$(nproc --all)

# Define the desired maximum CPU load
MAX_CPU_LOAD=70

# Define the duration for each state (in seconds)
CYCLE_DURATION=5 # Switch every 5 seconds

echo "Starting CPU stress test with random load (0% to ${MAX_CPU_LOAD}%) every ${CYCLE_DURATION} seconds..."
echo "Number of CPU cores detected: ${NUM_CORES}"
echo "Press Ctrl+C to stop the test."

# Trap for Ctrl+C to ensure clean exit
trap "echo -e '\nStopping stress test...'; pkill -f 'stress-ng'; echo 'Ensured all stress-ng processes are terminated.'; exit 0" SIGINT SIGTERM

# Loop indefinitely
while true; do
    # --- Step 1: Ensure any previous stress-ng processes are terminated ---
    echo -n "$(date): [INFO] Attempting to kill any lingering stress-ng processes... "

    PIDS_TO_KILL=$(pgrep -f "stress-ng --cpu")
    if [ -n "$PIDS_TO_KILL" ]; then
        echo "Found PIDs: ${PIDS_TO_KILL}. Killing..."
        kill $PIDS_TO_KILL &>/dev/null
        sleep 0.5 # Give it a moment to terminate
    else
        echo "No active stress-ng processes found."
    fi

    # --- Step 2: Generate a random CPU load percentage compatible with /bin/sh ---
    RAND_CPU_LOAD=-1 # Initialize with an invalid value to ensure loop runs
    while [ "$RAND_CPU_LOAD" -lt 0 ] || [ "$RAND_CPU_LOAD" -gt "$MAX_CPU_LOAD" ]; do
        # Generate a random 2-byte number from /dev/urandom
        # Use od -An -N2 -i to read 2 bytes, interpret as integer, no address/offset
        # Then trim whitespace and handle potential negative numbers (though -i usually gives positive)
        RAW_RANDOM=$(od -An -N2 -i /dev/urandom | tr -d ' ')

        # Defensive check: if RAW_RANDOM is empty or not a number, retry
        if [ -z "$RAW_RANDOM" ] || ! expr "$RAW_RANDOM" + 0 >/dev/null 2>&1; then
            continue # Try again if not a number
        fi

        # Modulo arithmetic to get within desired range
        RAND_CPU_LOAD=$(( RAW_RANDOM % (MAX_CPU_LOAD + 1) ))
    done

    echo "$(date): [ACTION] Calculated random CPU load: ${RAND_CPU_LOAD}% for ${CYCLE_DURATION} seconds."

    # --- Step 3: Apply the CPU load or sleep for minimal load ---
    if [ "$RAND_CPU_LOAD" -eq 0 ]; then
        echo "   (RAND_CPU_LOAD is 0, skipping stress-ng for CPU, maintaining minimal load)"
        sleep "${CYCLE_DURATION}"
    else
        echo "   (Executing stress-ng --cpu ${NUM_CORES} --cpu-load ${RAND_CPU_LOAD} --timeout ${CYCLE_DURATION}s)"
        stress-ng --cpu "${NUM_CORES}" --cpu-load "${RAND_CPU_LOAD}" --timeout "${CYCLE_DURATION}s" --metrics-brief &
        sleep "${CYCLE_DURATION}"
    fi

done
