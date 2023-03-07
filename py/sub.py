# subscriber
import paho.mqtt.client as mqtt
import pyautogui
from host_address import host_ip, port
import pyautogui


client = mqtt.Client()
#your ip and port
client.connect(host=host_ip, port=port)

def on_connect(client, userdata, flags, rc):
    print("Connected to a broker!")
    client.subscribe("topic/test")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))
    barcode = msg.payload.decode()
    pyautogui.typewrite(barcode)
    pyautogui.press("return")

while True:
    client.on_connect = on_connect
    client.on_message = on_message
    client.loop_forever()