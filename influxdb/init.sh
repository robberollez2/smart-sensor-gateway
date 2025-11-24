#!/bin/bash
set -e

echo "Waiting for InfluxDB to be ready..."
sleep 5

echo "Applying InfluxDB dashboard template (if possible)..."

influx apply \
  -f /docker-entrypoint-initdb.d/sensor_gateway.json \
  -o "$DOCKER_INFLUXDB_INIT_ORG" \
  -t "$DOCKER_INFLUXDB_INIT_ADMIN_TOKEN" \
  --force yes || echo "Template apply failed (misschien al toegepast); ga gewoon verder."

# Heel belangrijk: nooit met error stoppen, anders blijft de container loopen
exit 0
