FROM python:3.11-slim

WORKDIR /app

# paho-mqtt installeren
RUN pip install --no-cache-dir paho-mqtt

# jouw script kopiëren
COPY sensor_sim.py .

# script draaien
CMD ["python", "sensor_sim.py"]
