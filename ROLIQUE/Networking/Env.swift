//
//  Env.swift
//  Networking
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation

struct Env {
  static let apiToken: String = Env.getValueForKey("ApiToken") ?? "no_api_token"
  static let apiUrl: String = Env.getValueForKey("ApiUrl") ?? "no_api_url"
  static let slackCliendId = Env.getValueForKey("SlackClientId") ?? "no_slack_client_id"
  static let slackCliendSecret = Env.getValueForKey("SlackClientSecret") ?? "no_slack_client_secret"

  static func getValueForKey(_ key: String) -> String? {
    guard let secret = Bundle.main.infoDictionary?["Secret"] as? [String: Any] else { return nil }
    guard let value = secret[key] as? String else { return nil }
    return value
  }
}
