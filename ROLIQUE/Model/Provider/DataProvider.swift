//
//  DataProvider.swift
//  ROLIQUE
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation
import Networking
import Combine

public struct Action {
   public class Late {}
}

public struct Fetch<M: Model> {}

public class FetchArray<A: Model> {}

public class FetchUsers: FetchArray<User> {}

//TODO: implement combine Publisher
public extension Action.Late {
  static func please() {
    let latePublisher = PassthroughSubject<ActionResult, Error>()
    let subscriber = latePublisher.handleEvents(
      receiveSubscription: { (subscription) in
        print("new subscription")
    }, receiveOutput: { (actionResult) in
      print("new output")
    }, receiveCompletion: { (lateError) in
      print("completed with error: \(lateError)")
    }, receiveCancel: {
      print("subscription cancelled")
    }).sink(receiveCompletion: { (lateError) in
      print("sink completed with error: \(lateError)")
    }, receiveValue: { (value) in
      print("received value \(value)")
    })
  }
  
  static func fromNow(value: String, sender: String, onSuccess: ((ActionResult) -> Void)?, onError: Net.ErrorResult?) {
    Net.Worker.request(Late(sender: sender, from: .now, value: value, isTest: false), onSuccess: { json in
      let result = ActionResult(error: Json.parse(json.stringValue)?["error"] as? String)
      onSuccess?(result)
    }, onError: onError)
  }
}

