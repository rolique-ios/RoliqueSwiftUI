//
//  ViewModel.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import Foundation

public protocol ViewModel {}
class BaseViewModel: ViewModel {
  deinit {
    print("☠️\(String(describing: self))☠️")
  }
}
