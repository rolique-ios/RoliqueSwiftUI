//
//  Net.swift
//  Networking
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public struct Net {
  public typealias JsonResult = (Json) -> Void
  public typealias ErrorResult = (Error) -> Void
  public typealias RouteInvocation = (Route) -> Void
  
  public struct Worker {}
}

public protocol NetworkerCompatible {
  var route: Route { get }
  var onSuccess: Net.JsonResult? { get }
  var onError: Net.ErrorResult? { get }
  
  func now()
}

public extension NetworkerCompatible {
  func now() {
    Net.Worker.request(route, onSuccess: onSuccess, onError: onError)
  }
}

public extension Net.Worker {
  static func request(_ route: Route, onSuccess: Net.JsonResult?, onError: Net.ErrorResult?) {
    do {
      URLSession.shared.dataTask(with: try route.asRequest(), completionHandler: { (data, response, error) in
        guard error == nil else { onError?(error!); return }
        guard let httpResponse = response as? HTTPURLResponse else {
          onError?(NSError(domain: "rolique", code: 700, userInfo: [NSLocalizedFailureReasonErrorKey: "no data"]))
          return }
        let code = httpResponse.statusCode
        guard let data = data else { onError?(NSError(domain: "rolique", code: code, userInfo: [NSLocalizedFailureReasonErrorKey: "no data"])) ; return }
        guard let jsonString = String(data: data, encoding: .utf8) else {
          do {
            let json = try JSONDecoder().decode(Json.self, from: data)
            onSuccess?(json); return
          } catch let error {
            onError?(error); return
          }
        }
        onSuccess?(Json(stringValue: jsonString))
      }).resume()
    } catch {
      onError?(error)
    }
  }
}
