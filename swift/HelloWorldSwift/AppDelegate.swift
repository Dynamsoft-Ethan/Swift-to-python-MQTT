//
//  AppDelegate.swift
//  HelloWorldSwift
//
//  Copyright © Dynamsoft. All rights reserved.
//

import UIKit
import CocoaMQTT
import Foundation




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, DBRLicenseVerificationListener {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 15.0,*) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 59.003 / 255.0, green: 61.9991 / 255.0, blue: 69.0028 / 255.0, alpha: 1)
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        

        // Initialize license.
        // The license string here is a time-limited trial license. Note that network connection is required for this license to work.
        // You can also request an extension for your trial license in the customer portal: https://www.dynamsoft.com/customer/license/trialLicense?product=dbr&utm_source=installer&package=ios
        DynamsoftBarcodeReader.initLicense("t0068NQAAAAGDOszWOMUI0bFmmFDTJl97olq2+CiK7pXwP7X1UiJvGR3/vpaIRe1VTSm9tKGufV3NRR4fTnpqMOAtwE6UmZo=", verificationDelegate: self)
        // Override point for customization after application launch.
        return true
    }
    
    func dbrLicenseVerificationCallback(_ isSuccess: Bool, error: Error?) {
        var msg:String? = nil
        if(error != nil)
        {
            let err = error as NSError?
            msg = err!.userInfo[NSUnderlyingErrorKey] as? String
            DispatchQueue.main.async {
                var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
                topWindow?.rootViewController = UIViewController()
                let alert = UIAlertController(title: "Server license verify failed", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                    topWindow?.isHidden = true
                    topWindow = nil
                 })
                topWindow?.makeKeyAndVisible()
                topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

