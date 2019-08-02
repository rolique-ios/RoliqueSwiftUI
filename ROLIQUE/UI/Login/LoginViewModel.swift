//
//  LoginViewModel.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Model
import AuthenticationServices

public protocol LoginViewModel: ViewModel {
  var onError: PassthroughSubject<Error, Never> { get }
  var onSuccessLogin: PassthroughSubject<User, Never> { get }

  func login(presentationAnchor: ASPresentationAnchor)
}

public final class LoginViewModelImpl: LoginViewModel {
  public var onError = PassthroughSubject<Error, Never>()
  public var onSuccessLogin = PassthroughSubject<User, Never>()


  public init() {}
  public func login(presentationAnchor: ASPresentationAnchor) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0) { [weak self] in
      guard let self = self else { return }
    
      let lm: LoginManager = LoginManagerImpl(presentationAnchor: presentationAnchor)
      lm.login(onSuccess: self.onSuccessLogin, onError: self.onError)
//      let am: ActionManger = ActionMangerImpl()
//      let action = ActionLate(sender: "U1TRSDJSY", from: "now", value: "5_m")
//      am.sendAction(action, subject: self.onSuccessLogin)
      
    }
  }
}

enum General: LocalizedError {
  case somethingWentWrong
}
