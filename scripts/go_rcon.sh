#!/bin/bash

RCON_HOST="127.0.0.1"
RCON_PORT=25575
ADMIN_PASSWORD="yourpass"

rcon_cli_path="/home/steam/palworld/scripts/rcon/rcon"

$rcon_cli_path -a "$RCON_HOST:$RCON_PORT" -p "$ADMIN_PASSWORD"
