//
//  ActionResult.swift
//  Model
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation

public final class ActionResult: Model, CustomStringConvertible {
  
  var ok: Bool { return error == nil }
  public var description: String {
    return "ActionResult -> ok: \(ok), error: \(error ?? "nil")"
  }

}
