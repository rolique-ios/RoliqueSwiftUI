//
//  UserDefaulsHelper.swift
//  Utils
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public struct AppUserDefaults {
  @UserDefault(key: "firstTime")
  public static var firstTime: Bool
}
