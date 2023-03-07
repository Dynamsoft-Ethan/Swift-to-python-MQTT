# subscriber
import paho.mqtt.client as mqtt
import pyautogui
import config
import pyperclip
import sys
import time
from host_address import host_ip, port


client = mqtt.Client()
#your ip and port
client.connect(host=host_ip, port=port)

def on_connect(client, userdata, flags, rc):
    print("Connected to a broker!")
    client.subscribe("topic/test")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))
    barcode = msg.payload.decode()
    if config.text_to_prepend != "":
      barcode = config.text_to_prepend + barcode
    if config.text_to_append != "":
      barcode = barcode + config.text_to_append
    for key in config.keys_to_prepend:
      pyautogui.press(key)
    pyperclip.copy(barcode)
    time.sleep(0.5)
    if sys.platform == 'darwin':
      pyautogui.hotkey('command', 'v')
    else:
      pyautogui.hotkey('ctrl', 'v')
    for key in config.keys_to_append:
      pyautogui.press(key)

while True:
    client.on_connect = on_connect
    client.on_message = on_message
    client.loop_forever()