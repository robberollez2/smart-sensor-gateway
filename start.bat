#!/bin/bash
set -e

# Optioneel: laatste versie van images binnenhalen
docker compose pull

# (Re)build custom images (Node-RED)
docker compose build

# Oude stack stoppen
docker compose down

# Nieuwe stack opstarten
docker compose up -d

docker compose down

# InfluxDB data leegmaken zodat setup/init opnieuw lopen
echo "Verwijderen van InfluxDB data..."
rm -rf ./influxdb/data/
mkdir -p ./influxdb/data/

# Nieuwe stack opstarten
docker compose up -d