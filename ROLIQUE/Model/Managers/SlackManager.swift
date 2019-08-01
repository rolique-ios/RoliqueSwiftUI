//
//  SlackManager.swift
//  Model
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import Networking
import AuthenticationServices

public protocol SlackManager {
  func showLogin(userSlackIdResult: ((String) -> Void)?, errorResult: ((Error) -> Void)?)
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

public final class SlackManagerImpl: SlackManager {
  
  let contextProvider: ASWebAuthenticationPresentationContextProviding
  
  public init(presentationAnchor: ASPresentationAnchor) {
    self.contextProvider = WindowProvider(presentationAnchor: presentationAnchor)
  }
  
  private var session: ASWebAuthenticationSession?
  
  public func showLogin(userSlackIdResult: ((String) -> Void)?, errorResult: ((Error) -> Void)?) {
    let route = SlackLogin()
    guard let url = try? route.asRequest().url else { return }
    
    session = ASWebAuthenticationSession(
        url: url,
        callbackURLScheme: "rolique://",
        completionHandler: {(callbackURL, error) in
            if error == nil {
                let query = callbackURL?.query?.components(separatedBy: "=")
                if query![0] == "code" {
                  let accessCode = query![1]
                  let route = SlackToken(code: accessCode)
                  Net.Worker.request(route, onSuccess: { json in
                    guard let userSlackId = Json.get(json: json, keyPath: "user/id") as? String else {
                      return
                    }
                    userSlackIdResult?(userSlackId)
                  }, onError: { error in errorResult?(error) })
              }
          }
    })
    session?.presentationContextProvider = contextProvider
    session?.start()
  }
  
}
