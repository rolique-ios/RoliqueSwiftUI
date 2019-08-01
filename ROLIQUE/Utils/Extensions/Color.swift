//
//  Color.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI
import UIKit

public extension Color {
  init(hex: String) {
    self.init(UIColor.init(hex: hex) ?? .clear)
  }
  
  static var random: Color {
    Color(UIColor.random)
  }
}
