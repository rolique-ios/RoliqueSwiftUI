//
//  LoginManager.swift
//  Model
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import UIKit
import Networking
import AuthenticationServices
import Combine

public protocol LoginManager {
  func login(onSuccess: PassthroughSubject<User, Never>, onError: PassthroughSubject<Error, Never>)
}

class WindowProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return presentationAnchor
  }
  
  let presentationAnchor: ASPresentationAnchor
  
  init(presentationAnchor: ASPresentationAnchor) {
    self.presentationAnchor = presentationAnchor
    super.init()
  }
}

public final class LoginManagerImpl: LoginManager {
  
  let contextProvider: ASWebAuthenticationPresentationContextProviding
  
  public init(presentationAnchor: ASPresentationAnchor) {
    self.contextProvider = WindowProvider(presentationAnchor: presentationAnchor)
  }
  
  private var session: ASWebAuthenticationSession?
  
  public func login(onSuccess: PassthroughSubject<User, Never>, onError: PassthroughSubject<Error, Never>) {
    guard let url = try? SlackLogin().asRequest().url else { return }
    
    session = ASWebAuthenticationSession(
      url: url,
      callbackURLScheme: "rolique://",
      completionHandler: {(callbackURL, error) in
        if error == nil {
          let query = callbackURL?.query?.components(separatedBy: "=")
          if query![0] == "code" {
            let code = query![1]
            Net.Worker.request(SlackToken(code: code), onSuccess: { jsonResult in
              guard let userSlackId = jsonResult.string("user/id") else {
                DispatchQueue.main.async {
                  let error = NSError(domain: "rolique", code: 777, userInfo: [NSLocalizedDescriptionKey: "failed to get string value by keypath: user/id"])
                  onError.send(error)
                }
                return
              }
              DispatchQueue.main.async {
                let user = User(id: userSlackId)
                dump(user)
                onSuccess.send(user)
              }
            }, onError: { error in
              DispatchQueue.main.async {
                onError.send(error)
              }
            })
          }
        }
    })
    session?.presentationContextProvider = contextProvider
    session?.start()
  }
  
}
