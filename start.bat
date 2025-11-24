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