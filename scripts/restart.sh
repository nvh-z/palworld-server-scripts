#!/bin/bash

RCON_HOST="127.0.0.1"
RCON_PORT=25575
ADMIN_PASSWORD="yourpass"

# Function to send RCON commands
send_rcon_command() {
    local rcon_cli_path="/home/steam/palworld/scripts/rcon/rcon"

    echo -n "$1" | $rcon_cli_path -a "$RCON_HOST:$RCON_PORT" -p "$ADMIN_PASSWORD"
}

# Send commands
send_rcon_command 'broadcast Auto_Reboot_Initialized'
send_rcon_command 'save'
send_rcon_command 'broadcast Server_is_going_to_reboot_in_5_minutes'
sleep 300
send_rcon_command 'broadcast Server_is_going_to_reboot_in_60_seconds'
sleep 60
send_rcon_command 'broadcast Server_is_going_to_reboot_in_30_seconds'
send_rcon_command 'broadcast Please_log_out_will_save_progress_now'
send_rcon_command 'save'
send_rcon_command 'broadcast Saved_progress'
sleep 30
send_rcon_command 'broadcast Server_is_going_to_reboot_in_10_seconds'
sleep 10

# Shut down the server
send_rcon_command 'shutdown 5 Reboot_in_5_seconds'

# Running backup script
/home/steam/palworld/scripts/backup.sh

# Wait for 30 seconds after shutdown command
sleep 30

# Restart the server in the screen session
#screen -S palworld_memory -X quit  # Stop the current screen session
#sleep 5 # Wait a bit to make sure screen is ended
screen -S palworld -X quit # Stop the current screen session for memory usage
sleep 10                   # Wait a bit to ensure the screen session has ended
screen -S palworld -dm bash -c '/home/steam/palworld/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS -players=16'  # Start a new screen session running PalServer.sh
sleep 10 # Wait after server has started
#screen -S palworld_memory -dm bash -c '/home/steam/palworld/scripts/memory_usage.sh' # Start new memory usage screen
