//
//  ShortcutManager.swift
//  UI
//
//  Created by Bohdan Savych on 8/2/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import UIKit
import Model
import Combine
import Utils
import SwiftUI

public final class ShortcutManager {
  public enum Action: Int, CaseIterable {
    case dopracNow,
    late1hour,
    remoteToday,
    remoteTomorrow,
    sickToday
    
    var title: String {
      switch self {
      case .dopracNow:
        return "Doprac"
      case .remoteToday, .remoteTomorrow:
        return "Remote"
      case .late1hour:
        return "Late"
      case .sickToday:
        return "Sick"
      }
    }
    
    var subtitle: String {
      switch self {
      case .dopracNow:
        return "Now"
      case .remoteToday:
        return "Today"
      case .remoteTomorrow:
        return "Tomorrow"
      case .late1hour:
        return "1 hour"
      case .sickToday:
        return "Today"
      }
    }
    
    init(shortcutItem: UIApplicationShortcutItem) {
      self = Action(rawValue: Int(shortcutItem.type)!)!
    }
    
    var shortcutItem: UIApplicationShortcutItem {
      UIApplicationShortcutItem(type: String(self.rawValue), localizedTitle: self.title, localizedSubtitle: self.subtitle, icon: nil, userInfo: nil)
    }
  }
  
  public static let shared = ShortcutManager()
  private init() {
    let _ = subject.sink { result in
      print("\(result)")
    }
  }
  
  public func buildShortcutItems() -> [UIApplicationShortcutItem] {
    Action.allCases.map { $0.shortcutItem }
  }
  
  private var subject = PassthroughSubject<ActionResult, Never>()
  
  public func handle(shortcutItem: UIApplicationShortcutItem) -> Bool {
    let action = Action(shortcutItem: shortcutItem)
    let am: ActionManger = ActionMangerImpl()
    
    switch action {
    case .late1hour:
      if let userId = UserDefaulsHelper.userId {
        let action = ActionLate(sender: userId, from: "now", value: "1_h")
        am.sendAction(action, subject: self.subject)
      }
    default:
      break
    }
    return true
  }
}
