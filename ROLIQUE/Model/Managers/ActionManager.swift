//
//  ActionManager.swift
//  Model
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation
import Networking
import Combine

public enum ActionType {
  
}

public protocol ActionManger {
  func sendAction(_ action: Action, subject: PassthroughSubject<ActionResult, Never>)
}

public final class ActionMangerImpl: ActionManger {
  
  public init() {}
  
  public func sendAction(_ action: Action, subject: PassthroughSubject<ActionResult, Never>) {
    Net.Worker.request(action.makeCommand(), onSuccess: { json in
      DispatchQueue.main.async {
        subject.send(ActionResult(map: json.dict()))
      }
    }, onError: { error in
      DispatchQueue.main.async {
        subject.send(ActionResult(error: error))
      }
    })
  }
}
