//
//  SlackManager.swift
//  Model
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import SafariServices

public protocol SlackManager {
  func showLogin()
}

public final class SlackManagerImpl: SlackManager {
  private let authURL = URL(string: "https://slack.com/oauth/authorize")!
  private let scope = "identity%3Abasic"
  private let clientId = ""
  
  public static let shared = SlackManagerImpl()
  private var session: SFAuthenticationSession? = nil


  // TODO: refactor later
  public func showLogin() {
    let url = URL(string: authURL.absoluteString + "?client_id=\(clientId)&scope=users:read&redirect_uri=rolique://")!
    let callbackUrlScheme = "rolique://"
    print("\(url.absoluteString)")
    
    session = SFAuthenticationSession(
        url: url,
        callbackURLScheme: callbackUrlScheme,
        completionHandler: {(callbackURL, error) in
            if error == nil {
                let query = callbackURL?.query?.components(separatedBy: "=")
                if query![0] == "code" {
                  let accessCode = query![1]
                  print("\(accessCode)")
              }
            }
    })
    
    session?.start()
  }
  
  private func getAccessToken(code: String) {

  //      Alamofire.request( SLACK_OAUTH_URL + "?client_id=\(env["SLACK_CLIENT_ID"]!)&client_secret=\(env["SLACK_CLIENT_SECRET"]!)&code=\(code)").responseJSON{
//          response in
//          let json = JSON(response.result.value!)
//          print("access_token:\(json["access_token"])")
//          RealmUserDataManager().setData(slackAccessToken: json["access_token"].description, hId: nil, hIdentifier: nil)
//      }
  }
}
