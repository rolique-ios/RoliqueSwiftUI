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

public protocol LoginViewModel: ViewModel {
  var onError: PassthroughSubject<Error, Never> { get }
  var onSuccessLogin: PassthroughSubject<Void, Never> { get }

  func login()
}

public final class LoginViewModelImpl: LoginViewModel {
  public var onError = PassthroughSubject<Error, Never>()
  public var onSuccessLogin = PassthroughSubject<Void, Never>()


  public init() {}
  public func login() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
      guard let self = self else { return }
      if Bool.random() {
        self.onError.send(General.somethingWentWrong)
      } else {
        self.onSuccessLogin.send()
      }
    }
  }
}

enum General: LocalizedError {
  case somethingWentWrong
}
