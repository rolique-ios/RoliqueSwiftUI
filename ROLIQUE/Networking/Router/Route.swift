//
//  Route.swift
//  Networking
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public class Route {
  
  struct Constants {
    static let baseApiPath = "https://roliqbot.appspot.com/api/"
    static let authHeaders: Headers = ["token": ProcessInfo.processInfo.environment["ROLIQUE_API_TOKEN"] ?? "no token"]
  }
  
  public enum Method: String {
    case get, post, put, patch, delete
    var value: String {
      return self.rawValue.uppercased()
    }
  }
  
  public typealias Headers = [String: String]
  public typealias Params = [String: String]
  
  public let endpoint: String
  public let method: Route.Method
  public let headers: Route.Headers
  public let urlParams: Route.Params
  public let body: Route.Params
  
  init (endpoint: String, method: Route.Method, headers: Route.Headers = Constants.authHeaders, urlParams: Route.Params = [:], body: Route.Params = [:]) {
    self.endpoint = endpoint
    self.method = method
    self.headers = headers
    self.urlParams = urlParams
    self.body = body
  }
  
  private func makeURL() -> URL? {
    return URL(string: Route.Constants.baseApiPath + endpoint)
  }
  
  public func asRequest() throws -> URLRequest {
    guard var url = makeURL() else { throw NSError(domain: "rolique", code: 700, userInfo: [NSLocalizedFailureReasonErrorKey: "Failed to make url"]) }
    if urlParams.keys.count > 0 {
      urlParams.keys.forEach { url = url.appending($0, value: urlParams[$0]) }
    }
    var request = URLRequest(url: url,
                      cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                      timeoutInterval: 30)
    request.allHTTPHeaderFields = headers
    request.httpMethod = method.value
    return request
  }
}

extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
