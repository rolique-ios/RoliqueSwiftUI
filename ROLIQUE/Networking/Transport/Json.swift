//
//  Json.swift
//  ROLIQUE
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public struct Json: Codable {
  public let stringValue: String
}

public extension Json {
  static func parse(_ jsonString: String) -> [String: Any]? {
    guard let data = jsonString.data(using: .utf8) else {
      return nil
    }
    return try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
  }
}
