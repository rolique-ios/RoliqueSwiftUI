//
//  ActionManager.swift
//  Model
//
//  Created by Andrii on 8/1/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import Foundation
import Networking

public enum ActionType {
  
}

public protocol ActionManger {
  func sendAction(_ action: ActionType)
}

public final class ActionMangerImpl: ActionManger {
  public func sendAction(_ action: ActionType) {

  }
  
  
}
