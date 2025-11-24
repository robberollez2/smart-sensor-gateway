import time
import json
import random
import paho.mqtt.client as mqtt

BROKER_HOST = "mqtt"
BROKER_PORT = 1883

client = mqtt.Client()
client.connect(BROKER_HOST, BROKER_PORT, 60)

try:
    while True:
        joy_payload = {
            "x": round(random.uniform(-1, 1), 2),
            "y": round(random.uniform(-1, 1), 2),
        }
        client.publish("controller/joystick", json.dumps(joy_payload))

        pressed = random.choice([0, 1])  # 0 = niet ingedrukt, 1 = ingedrukt

        btn_payload = {
            "button": "X",
            "pressed": pressed
        }

        client.publish("controller/button", json.dumps(btn_payload))


        print("Sent:", joy_payload)
        time.sleep(1)

except KeyboardInterrupt:
    print("Stopped by user")
finally:
    client.disconnect()