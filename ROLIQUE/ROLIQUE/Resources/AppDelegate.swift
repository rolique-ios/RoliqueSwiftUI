//
//  AppDelegate.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import Model

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Action.Late.fromNow(value: "6_h", sender: "U1TRSDJSY", onSuccess: { result in print(result) }, onError: { error in print(error) })
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
    return true
  }
}
