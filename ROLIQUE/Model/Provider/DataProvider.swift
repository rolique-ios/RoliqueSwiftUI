//
//  DataProvider.swift
//  ROLIQUE
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation
import Networking
import Combine

public struct Action {
   public class Late {}
}

public struct Fetch<M: ModelType> {}

public class FetchArray<A: ModelType> {}

public class FetchUsers: FetchArray<User> {}

//TODO: implement combine Publisher
public extension Action.Late {
  struct Demand {
    public let from: String
    public let value: String
    public let sender: String
    
    public init (from: String,value: String,sender: String) {
      self.from = from
      self.value = value
      self.sender = sender
    }
  }
  
  static func please(demand: Demand, publisher: PassthroughSubject<ActionResult, Error>) {
    Net.Worker.request(
      Late(sender: demand.sender, from: demand.from, value: demand.value, isTest: true),
      onSuccess: {
        let result = ActionResult(map: Json.parse($0.stringValue))
        publisher.send(result)
    },
      onError: {
        print($0)
        publisher.send(ActionResult(error: $0))
    })
  }
  
  static func fromNow(value: String, sender: String, result: ((ActionResult) -> Void)?) {
    Net.Worker.request(
      Late(sender: sender, from: "now", value: value, isTest: true),
      onSuccess: {
        result?(ActionResult(map: Json.parse($0.stringValue)))
    },
      onError: {
        result?(ActionResult(error: $0))
    })
  }
  
  static func fromStart(value: String, sender: String, result: ((ActionResult) -> Void)?) {
    Net.Worker.request(
      Late(sender: sender, from: "start", value: value, isTest: true),
      onSuccess: {
        result?(ActionResult(map: Json.parse($0.stringValue)))
    },
      onError: {
        result?(ActionResult(error: $0))
    })
  }
}

