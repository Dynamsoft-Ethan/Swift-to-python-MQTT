# publisher
import paho.mqtt.client as mqtt

client = mqtt.Client()
# your ip and port
client.connect('192.168.8.207', 1883)

while True:
    message = input("message: ")
    client.publish("topic/test", message)
