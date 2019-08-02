//
//  ProfileView.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI
import Utils

public struct ProfileView: View {
  private let viewModel: ProfileViewModel
  
  public init(viewModel: ProfileViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Colors.Login.backgroundColor
      Button("test") {
        self.testForAndrii()
      }
      .padding(10)
      .background(Color.white)
    }
  }
}


// MARK: - Private
private extension ProfileView {
  func testForAndrii() {
    
  }
}
