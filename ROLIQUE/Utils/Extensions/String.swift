//
//  String.swift
//  Utils
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public extension String {
  var localized: String {
    NSLocalizedString(self, comment: self)
  }
  
  var firstUppercased: String {
    let symbols = Array(self)
    let first = symbols.first?.uppercased()
    let other = String(symbols[1...]).lowercased()
    return first.orEmpty + other
  }
}
