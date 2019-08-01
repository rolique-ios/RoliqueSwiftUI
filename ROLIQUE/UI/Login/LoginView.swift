//
//  LoginView.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import UIKit
import Utils
import SwiftUI

private struct Constants {
  static var logoSize: CGSize { return CGSize(width: 150, height: 150) }
  static var edgeInsets: EdgeInsets { return EdgeInsets(top: 100, leading: 8, bottom: 40, trailing: 8) }
  static var slackButtonSize: CGSize { return CGSize(width: 200, height: 150) }
}

public struct LoginView: View {
  private let viewModel: LoginViewModel
  
  public init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Colors.Login.backgroundColor.edgesIgnoringSafeArea(.all)
      VStack {
        self.composeLogo()
        Spacer()
        self.composeSlackButton()
      }.padding(Constants.edgeInsets)
    }
  }
}

// MARK: - Private
private extension LoginView {
  func composeSlackButton() -> some View {
    Button(action: {
      self.viewModel.login()
    }) {
      Images.Login.slackButton
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: Constants.slackButtonSize.width, height: Constants.slackButtonSize.height)
    }
  }
  
  func composeLogo() -> some View {
    return
      Images.Login.fullLogo
      .renderingMode(.original)
      .resizable()
      .frame(width: Constants.logoSize.width, height: Constants.logoSize.height)
      .padding(.all, 20)
      .border(Color.white, width: 1, cornerRadius: 5)
  }
}
