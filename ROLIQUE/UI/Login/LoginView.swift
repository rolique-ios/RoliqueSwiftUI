//
//  LoginView.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import SwiftUI

public struct LoginView: View {
  private let viewModel: LoginViewModel
  
  public init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    Group {
      ZStack {
        Colors.Login.backgroundColor.edgesIgnoringSafeArea(.all)
      }
    }
  }
}