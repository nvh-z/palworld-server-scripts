# palworld-server-scripts
You can find every script in scripts folder. Crontab included, meant for ubuntu.

https://github.com/gorcon/rcon-cli/releases
rcon folder is used through this repo, much appreciated and all rights reserved for the rcon-cli developer.

# Start.sh
Simple script which will start the server through ubuntu screens.

# Restart.sh
Will restart the server while running, broadcasts messages through rcon.

# Memory usage.sh
This script runs every * based on your crontab. It will check how much ram you have left on your server. Can also manually run.
Simply checks what palserver is using, when it hits the threshold it will shutdown your palserver.

# Go rcon.sh
This is simply a script to log in into rcon through your ubuntu environment. It will let you run commands through rcon that will connect them into in game.

# Backup.sh
Will backup pal server files in a tar.gz
