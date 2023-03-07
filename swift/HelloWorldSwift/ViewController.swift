//
//  ViewController.swift
//  HelloWorldSwift
//
//  Copyright © Dynamsoft. All rights reserved.
//

import UIKit
import CocoaMQTT
import Foundation
import DynamsoftCameraEnhancer
import DynamsoftBarcodeReader

class ViewController: UIViewController, DBRTextResultListener {
    
    var dce:DynamsoftCameraEnhancer!
    var dceView:DCECameraView!
    var barcodeReader:DynamsoftBarcodeReader!
    
    //define your host and topic here:
    var mqttClient = CocoaMQTT(clientID: "myID", host: "192.168.8.207", port: 1883)
    var topic = "topic/test"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 59.003 / 255.0, green: 61.9991 / 255.0, blue: 69.0028 / 255.0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is a sample that illustrates how to quickly set up a video barcode scanner with Dynamsoft Barcode Reader.
        configurationDBR()
        
        //Create a camera module for video barcode scanning. In this section Dynamsoft Camera Enhancer (DCE) will handle the camera settings.
        configurationDCE()
        
        // Connect to the MQTT broker
        mqttClient.connect()
    }
    
    func configurationDBR() {
        barcodeReader = DynamsoftBarcodeReader.init()
        barcodeReader.updateRuntimeSettings(EnumPresetTemplate.videoSingleBarcode)

        /*
        let settings:iPublicRuntimeSettings = try?barcodeReader.getRuntimeSettings()
        settings.barcodeFormatIds = EnumBarcodeFormat.ONED.rawValue | EnumBarcodeFormat.QRCODE.rawValue | EnumBarcodeFormat.DATAMATRIX.rawValue | EnumBarcodeFormat.PDF417.rawValue
        do{
            try barcodeReader.updateRuntimeSettings(settings)
        }catch{
            print("\(error)")
        }
        */
    }
    

    func configurationDCE() {
        //Initialize a camera view for previewing video.
        dceView = DCECameraView.init(frame: self.view.bounds)
        self.view.addSubview(dceView)

        // Initialize the Camera Enhancer with the camera view.
        dce = DynamsoftCameraEnhancer.init(view: dceView)
        
        
        //camera UI
        // scan regio https://www.dynamsoft.com/camera-enhancer/docs/programming/ios/primary-api/camera-enhancer.html#setscanregion
        
        let scanRegion = iRegionDefinition()
        scanRegion.regionTop = 25
        scanRegion.regionBottom = 75
        scanRegion.regionLeft = 25
        scanRegion.regionRight = 75
        scanRegion.regionMeasuredByPercentage = 1
        dce.setScanRegion(scanRegion, error: nil)
        
        
        //other UI customizations: https://www.dynamsoft.com/camera-enhancer/docs/programming/ios/primary-api/camera-enhancer.html#enablefeatures:~:text=the%20camera%20enhancer.-,Basic%20Camera%20Control%20Methods%20Summary,-Method
        
        
        // Open the camera to get video streaming.
        dce.open()

        // Bind Camera Enhancer to the Barcode Reader.
        // The Barcode Reader will get video frame from the Camera Enhancer
        barcodeReader.setCameraEnhancer(dce)

        // Set text result call back to get barcode results.
        barcodeReader.setDBRTextResultListener(self)

        // Start the barcode decoding thread.
        barcodeReader.startScanning()
        // Create a new MQTT client with a unique identifier



    }
    
    // Obtain the recognized barcode results from the textResultCallback and display the results
    func textResultCallback(_ frameId: Int, imageData: iImageData, results: [iTextResult]?) {
        if (results != nil){
            var msgText:String = ""
            let title:String = "Results"
            for item in results! {
                msgText = msgText + String(format:"\nFormat: %@\nText: %@\n", item.barcodeFormatString!,item.barcodeText ?? "noResuslt")
                // Publish a message to a topic
                mqttClient.publish(topic, withString: item.barcodeText ?? "noResuslt")
            }

            barcodeReader.stopScanning()
            DCEFeedback.vibrate()
            showResult(title, msgText, "OK") {
                self.barcodeReader.startScanning()
            }
        }else{
            return
        }
    }
    
    private func showResult(_ title: String, _ msg: String, _ acTitle: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: acTitle, style: .default, handler: { _ in completion() }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
