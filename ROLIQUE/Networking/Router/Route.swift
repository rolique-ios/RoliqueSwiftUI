//
//  Route.swift
//  Networking
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public class Route {
  
//  struct Constants {
//    static let baseApiPath = Bundle.main.infoDictionary?["ApiUrl"] as? String ?? "no token"
//    static let authHeaders: Headers = ["token": Bundle.main.infoDictionary?["ApiToken"] as? String ?? "no token"]
//  }
  
  public enum Method: String {
    case get, post, put, patch, delete
    var value: String { self.rawValue.uppercased() }
  }
  
  public typealias Headers = [String: String]
  public typealias Params = [String: String]
  
  public let endpoint: String
  public let method: Route.Method
  public let headers: Route.Headers?
  public let urlParams: Route.Params
  public let body: Route.Params
  
  init (endpoint: String, method: Route.Method, headers: Route.Headers? = nil, urlParams: Route.Params = [:], body: Route.Params = [:]) {
    self.endpoint = endpoint
    self.method = method
    self.headers = headers
    self.urlParams = urlParams
    self.body = body
  }
  
  private func makeURL() -> URL? {
    let apiUrl = Bundle.main.infoDictionary?["ApiUrl"] as? String ?? "no_api_url"
    let urlString = "https://" + apiUrl + endpoint
    let url = URL(string: urlString)
    return url
  }
  
  private func makeAuthHeaders() -> Headers {
    let token = Bundle.main.infoDictionary?["ApiToken"] as? String ?? "no_token"
    return ["token": token]
  }
  
  public func asRequest() throws -> URLRequest {
    guard var url = makeURL() else { throw NSError(domain: "rolique", code: 700, userInfo: [NSLocalizedFailureReasonErrorKey: "Failed to make url"]) }
    if urlParams.keys.count > 0 {
      urlParams.keys.forEach { url = url.appending($0, value: urlParams[$0]) }
    }
    var request = URLRequest(url: url,
                      cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                      timeoutInterval: 30)
    request.allHTTPHeaderFields = headers ?? makeAuthHeaders()
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
