#!/bin/bash
set -e

# Optioneel: laatste versie van images binnenhalen
docker compose pull

# InfluxDB data leegmaken zodat setup/init opnieuw lopen
echo "Verwijderen van InfluxDB data..."
rm -rf ./influxdb/data/
mkdir -p ./influxdb/data/

# (Re)build custom images (Node-RED)
docker compose build

# Oude stack stoppen
docker compose down

# Nieuwe stack opstarten
docker compose up -d
