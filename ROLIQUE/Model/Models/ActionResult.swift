//
//  ActionResult.swift
//  Model
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public struct ActionResult: Codable, CustomStringConvertible {
  var error: String?
  var ok: Bool { return error == nil }
  public var description: String {
    return "ActionResult -> ok: \(ok), error: \(error ?? "nil")"
  }
}
