//
//  DataProvider.swift
//  ROLIQUE
//
//  Created by Andrii on 7/31/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation
import Networking
import Combine


public struct Fetch<M: ModelType> {}

public class FetchArray<A: ModelType> {}

public class FetchUsers: FetchArray<User> {}

protocol ProviderProtocol {
  associatedtype ModelType
  //@
  var bindableObject: ModelType? { get }
  
}

class Provider<M: Model>: ProviderProtocol {
  var bindableObject: M?
  
  typealias ModelType = M
  
}
