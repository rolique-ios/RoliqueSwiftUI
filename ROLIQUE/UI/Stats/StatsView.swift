//
//  StatsView.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI
import Utils

public struct StatsView: View {
  private let viewModel: StatsViewModel
  
  public init(viewModel: StatsViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Colors.Login.backgroundColor.edgesIgnoringSafeArea(.all)
    }
  }
}
