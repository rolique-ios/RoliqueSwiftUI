//
//  Images.swift
//  Utils
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation
import SwiftUI

public struct Images {
  public struct TabBar {
    public static var profile: Image {
      Image("profile")
    }
    
    public static var stats: Image {
      Image("stats")
    }
  }
  public struct Login {
    public static var fullLogo: Image {
      Image("logoFull")
    }
    
    public static var slackButton: Image {
      Image("slackButton")
    }
  }
}
