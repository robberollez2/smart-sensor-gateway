FROM nodered/node-red:latest

# Installeer de InfluxDB node één keer bij build
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production node-red-contrib-influxdb

# Data directory (flows, settings) komen via volume ./nodered/data