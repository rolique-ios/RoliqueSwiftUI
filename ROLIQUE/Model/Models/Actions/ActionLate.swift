//
//  ActionLate.swift
//  Model
//
//  Created by Andrii on 8/2/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation

public final class ActionLate: Action {
  public init(sender: String, from: String, value: String) {
    super.init(sender: sender, type: "late", props: ["from": from, "value": value])
  }
  
  required init(from decoder: Decoder) throws {
    try super.init(from: decoder)
  }
}

extension ActionLate {
  
}
