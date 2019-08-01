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
  func showLogin()
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
  
  public func showLogin() {
    let route = SlackLogin()
    guard let url = try? route.asRequest().url else { return }
    session = ASWebAuthenticationSession(
        url: url,
        callbackURLScheme: "rolique://",
        completionHandler: {(callbackURL, error) in
          print(error, callbackURL)
            if error == nil {
                let query = callbackURL?.query?.components(separatedBy: "=")
                if query![0] == "code" {
                  let accessCode = query![1]
                  print("\(accessCode)")
              }
            }
    })
    session?.presentationContextProvider = contextProvider
    session?.start()
  }
  
}
