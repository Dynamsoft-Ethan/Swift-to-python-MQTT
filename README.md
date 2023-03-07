# Swift-to-python-MQTT

Turn your phones into a remote barcode scanner that scans barcodes to desktop devices.

## recommend version
python 3.8

## Installation

1. python install:
```
   cd ./py
   pipenv shell
   pipenv install
```

or:
```
    cd ./py
    python -m pip install -r requirement.txt
```

2. swift install:
```
   cd ./swift
   pod install
```

3. define your server ip & port in `./py/host_address.py` and `./swift/HelloWorldSwift/ViewController.swift
`

> **Note:** The IP on my laptop is `192.168.8.207` thus I am using same IP in the project. You should replace the IP with your own IP. The port should be `1883` by convention.

## run:
1. python
```
    cd ./py
    python ./run.py
```
2. swift
connect your iOS device and run `./swift/HelloWorldSwift/HelloWorldSwift.xcworkspace` 

## video demo

<https://tst.dynamsoft.com/team/ethan/github/pythonswift.mp4>
