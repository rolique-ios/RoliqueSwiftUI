//
//  ShortcutManager.swift
//  UI
//
//  Created by Bohdan Savych on 8/2/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import UIKit

public final class ShortcutManager {
  public enum Action: Int, CaseIterable {
    case dopracNow,
    remoteToday,
    remoteTomorrow,
    late1hour,
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
    
    var shortcutItem: UIApplicationShortcutItem {
      UIApplicationShortcutItem(type: String(self.rawValue), localizedTitle: self.title, localizedSubtitle: self.subtitle, icon: nil, userInfo: nil)
    }
  }
  
  public static let shared = ShortcutManager()
  
  public func buildShortcutItems() -> [UIApplicationShortcutItem] {
    Action.allCases.map { $0.shortcutItem }
  }
  
  public func handle(shortcutItem: UIApplicationShortcutItem) -> Bool {
    return true
  }
}
