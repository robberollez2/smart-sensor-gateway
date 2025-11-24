#!/usr/bin/env bash
set -e

echo "==> Waiting for InfluxDB to be ready..."

# Kleine wachttijd om zeker te zijn dat setup klaar is
sleep 5

echo "==> Importing dashboard from /docker-entrypoint-initdb.d/sensor_gateway.json"

influx apply \
  --skip-verify \
  --org "$DOCKER_INFLUXDB_INIT_ORG" \
  --token "$DOCKER_INFLUXDB_INIT_ADMIN_TOKEN" \
  --file /docker-entrypoint-initdb.d/sensor_gateway.json

echo "==> Dashboard import completed."