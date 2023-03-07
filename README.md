# Swift-to-python-MQTT

Turn your phones into a remote barcode scanner that scans barcodes to desktop devices.

## Installation
1. python install:<br />
`
cd ./py<br />
pipenv shell<br />
pipenv install<br />
`
or<br />
`
cd ./py<br />
pip install -r requirrment.txt<br />
`

2. swift install:
`
cd ./swift
pod install
`

3. define your server ip/port in  ./py/host_address.py and ./swift/HelloWorldSwift/ViewController.swift

> **Note:** The IP on my laptop is 192.168.8.207 thus I am using same IP in the project. By convention, the port should be 1883

## run

`
cd ./py<br />
python ./run.py<br />
`

## video demo

<https://tst.dynamsoft.com/team/ethan/github/pythonswift.mp4>