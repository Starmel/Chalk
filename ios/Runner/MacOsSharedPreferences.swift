//
//  MacOsSharedPreferences.swift
//  Runner
//
//  Created by admin on 8/9/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import FlutterMacOS

class MacOsSharedPreferencesPlugin {
    
    class func enable(_ messenger: FlutterBinaryMessenger){
        
        let channel = FlutterMethodChannel(name: "plugins.flutter.io/shared_preferences", binaryMessenger: messenger)
        
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) in
            print("Got message =", call.method)
            switch call.method {
            case "setBool" :
                print("set bool")
                
            case "setDouble" :
                print("setDouble")
                
            case "setInt" :
                print("setInt")
                
            case "setString" :
                print("setString")
                
            case "setStringList" :
                print("commit")
                
            case "getAll" :
                print("getAll")
                
            case "remove" :
                print("remove")
                
            case "clear" :
                print("clear")
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
