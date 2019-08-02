//
//  UserDefaulsHelper.swift
//  Utils
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public struct UserDefaulsHelper {
  @UserDefault(key: "firstTime")
  public static var firstTime: Bool
  
  @UserDefault(key: "userId")
  public static var userId: String
}
