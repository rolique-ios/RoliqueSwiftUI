//
//  User.swift
//  Model
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation

public final class User: Model {
  
  enum CodingKeys: String, CodingKey {
      case id
  }
  
  var id: String
  
  init(id: String) {
    self.id = id
    super.init(map: ["id": id])
  }
  
  required init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try values.decode(String.self, forKey: .id)
    try super.init(from: decoder)
  }

  public override func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try super.encode(to: encoder)
  }
  
}
