//
//  SceneDelegate.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import UI
import SwiftUI
import Model

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let shortcut = connectionOptions.shortcutItem
    let _ = shortcut.map(ShortcutManager.shared.handle(shortcutItem:))
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: LoginView(viewModel: LoginViewModelImpl()))
    self.window = window
    window.makeKeyAndVisible()
  }
  
  func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    completionHandler(ShortcutManager.shared.handle(shortcutItem: shortcutItem))
  }
}

