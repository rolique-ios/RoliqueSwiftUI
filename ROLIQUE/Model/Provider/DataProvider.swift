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
    Net.Worker.request(Late(sender: sender, from: .now, value: value, isTest: true), onSuccess: { json in
      let result = ActionResult(map: Json.parse(json.stringValue))
      onSuccess?(result)
    }, onError: onError)
  }
}

