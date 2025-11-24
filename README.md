## Installatie

### 1. Vereisten

- Docker Desktop (Windows / macOS)  
  **of**
- Docker Engine + Docker Compose (Linux)

### 2. Repository clonen

```bash
git clone https://github.com/<jouw-repo>/smart-sensor-gateway.git
cd smart-sensor-gateway
```

### 3. `.env` verkrijgen en controleren

Het benodigde `.env`-bestand is verkrijgbaar bij **R. Rollez**.

De meegeleverde/verkregen `.env` bevat o.a.:

- InfluxDB gebruikersnaam
- InfluxDB wachtwoord
- Organisatienaam
- Bucketnaam
- Admin token (wordt ook gebruikt in Node-RED)

> ⚠️ **Belangrijk:** wijzig deze waarden niet, tenzij je bewust de volledige database opnieuw wilt initialiseren.

### 4. Node-RED configureren (InfluxDB token)

In Node-RED moet je in de InfluxDB-configuratie het **token** instellen dat overeenkomt met het token uit het `.env`-bestand:

1. Open Node-RED via `http://localhost:1880`.
2. Dubbelklik op 'Write joystick' of 'Write button events'.
3. Klik op het potloodje bij 'Server'.
3. Plak het token uit `.env` in het token-veld.
4. Deploy de flow opnieuw.

### 5. InfluxDB dashboard importeren

Het InfluxDB dashboard moet handmatig geïmporteerd worden met het bestand `influxdb/sensor_gateway.json`:

1. Ga naar `http://localhost:8086` en log in.
2. Navigeer naar **Dashboards** → **Import**.
3. Kies het bestand `influxdb/sensor_gateway.json` uit deze repository.

Dashboard instellen:
1. Klik op 'SET AUTO REFRESH'
2. Verander het interval naar 1s en klik op Confirm.
3. Stel het dashboard interval rechtsboven in op 'Past 1m'.

### 6. Stack opstarten

Start het volledige systeem:

```bash
docker compose up -d
```

De volgende containers starten automatisch:

- Mosquitto MQTT broker
- Node-RED
- InfluxDB (incl. dashboard)
- Portainer
- Sensor-simulator

### 5. Webinterfaces openen

| Service     | URL                   |
| ----------- | --------------------- |
| Node-RED    | http://localhost:1880 |
| InfluxDB UI | http://localhost:8086 |
| Portainer   | http://localhost:9000 |
| MQTT Broker | `localhost:1883`      |

InfluxDB logt automatisch in met de credentials uit `.env`.

---

## Troubleshooting

### ❗ Node-RED fout: "unauthorized access"

**Mogelijke oorzaak:**  
Token-mismatch tussen Node-RED en InfluxDB.

**Oplossing:**

1. Verwijder `nodered/data/flows_cred.json`
2. Stop de stack:
   ```bash
   docker compose down
   ```
3. Start opnieuw:
   ```bash
   docker compose up -d
   ```
4. **Of:** genereer in InfluxDB een nieuw token en update dit in Node-RED.

---

### ❗ InfluxDB blijft rebooten

**Oorzaak:**  
Corrupte of reeds bestaande databasebestanden.

**Oplossing:**

```bash
docker compose down
Remove-Item influxdb\data -Recurse -Force
docker compose up -d
```

---

### ❗ Geen MQTT-data in Node-RED

Controleer:

- Mosquitto-container draait:
  ```bash
  docker ps
  ```
- Sensor-simulator draait
- Node-RED MQTT-nodes gebruiken de juiste topics:
  - `controller/joystick`
  - `controller/button`

---

### ❗ Dashboard toont geen data

Controleer:

- In Node-RED debug of writes naar InfluxDB slagen
- Of het juiste bucket is ingesteld in `.env`
- Of de InfluxDB-service correct draait

---

### ❗ Node-RED toont geen flows

Zorg dat deze bestanden aanwezig zijn:

- `nodered/data/flows.json`
- `nodered/data/flows_cred.json`

Ontbreken ze?

- Flow opnieuw importeren **of**
- Repository opnieuw clonen.
