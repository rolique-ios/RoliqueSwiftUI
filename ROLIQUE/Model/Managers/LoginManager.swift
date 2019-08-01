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

public protocol LoginManager {
  func login(userSlackIdResult: ((String?) -> Void)?)
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

public final class SlackManagerImpl: LoginManager {
  
  let contextProvider: ASWebAuthenticationPresentationContextProviding
  
  public init(presentationAnchor: ASPresentationAnchor) {
    self.contextProvider = WindowProvider(presentationAnchor: presentationAnchor)
  }
  
  private var session: ASWebAuthenticationSession?
  
  public func login(userSlackIdResult: ((String?) -> Void)?) {
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
                print("failed to get string value by keypath: user/id")
                userSlackIdResult?(nil)
                return
              }
              userSlackIdResult?(userSlackId)
            }, onError: { error in
              print(error)
              userSlackIdResult?(nil) })
          }
        }
    })
    session?.presentationContextProvider = contextProvider
    session?.start()
  }
  
}
