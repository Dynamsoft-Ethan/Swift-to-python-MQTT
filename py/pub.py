# publisher
import paho.mqtt.client as mqtt
from host_address import host_ip, port

client = mqtt.Client()
# your ip and port
client.connect(host=host_ip, port=port)

while True:
    message = input("message: ")
    client.publish("topic/test", message)
