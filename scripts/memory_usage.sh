#!/bin/bash

RCON_HOST="127.0.0.1"
RCON_PORT=25575
ADMIN_PASSWORD="yourpass"
THRESHOLD=90

# Function to send RCON commands
send_rcon_command() {
    local rcon_cli_path="/home/steam/palworld/scripts/rcon/rcon"

    echo -n "$1" | $rcon_cli_path -a "$RCON_HOST:$RCON_PORT" -p "$ADMIN_PASSWORD"
}

# Check memory usage
MEMORY_USAGE=$(free | awk '/^Mem:/ {print $3/$2 * 100.0}')

if (( $(echo "$MEMORY_USAGE > $THRESHOLD" | bc -l) )); then
        echo "Memory usage is above $THRESHOLD%. Running clean command."

        # Sending RCON commands
        send_rcon_command "broadcast Memory_Is_Above_$THRESHOLD%"
	send_rcon_command "broadcast Please_log_out_will_save_progress_now"
        send_rcon_command "save"
	send_rcon_command "broadcast Saved_progress"
        send_rcon_command "shutdown 30 Reboot_In_30_Seconds"

        # Running backup script
        /home/steam/palworld/scripts/backup.sh

        # Wait for 30 seconds after shutdown command
        sleep 30

	# Restart the server in the screen session
	screen -S palworld -X quit # Stop the current screen session for memory usage
	sleep 10                    # Wait a bit to ensure the screen session has ended
	screen -S palworld -dm bash -c '/home/steam/palworld/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS -players=16'  # Start a new screen session running PalServer.sh
	sleep 10
else
	# Send memory usage to game via RCON
        send_rcon_command "broadcast Memory_usage_of_PalServer_${MEMORY_USAGE}%"
	send_rcon_command "broadcast Memory_usage_is_below_$THRESHOLD%_no_action_required."
	send_rcon_command "save"
	send_rcon_command "broadcast Saved_progress"

	echo "Memory usage is below $THRESHOLD%. No action required."
fi
