//
//  ProfileViewModel.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation
import Model
import Combine

public protocol ProfileViewModel: ViewModel {
  var onError: PassthroughSubject<Error, Never> { get }
  var onSuccess: PassthroughSubject<ActionResult, Never> { get }

  func sendAction(_ action: Action)
  func test()
}

public final class ProfileViewModelImpl: ProfileViewModel {
  public var onError = PassthroughSubject<Error, Never>()
  
  public var onSuccess = PassthroughSubject<ActionResult, Never>()
  
  public func test() {
    onSuccess.sink { result in
      print(result)
    }
    let action = ActionLate(sender: "U1TRSDJSY", from: "now", value: "1_h")
    sendAction(action)
  }
  
  public func sendAction(_ action: Action) {
    let am: ActionManger = ActionMangerImpl()
    am.sendAction(action, subject: self.onSuccess)
  }
}
