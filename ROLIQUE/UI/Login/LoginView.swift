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
import Model
import AuthenticationServices

private struct Constants {
  static var logoSize: CGSize { return CGSize(width: 150, height: 150) }
  static var edgeInsets: EdgeInsets { return EdgeInsets(top: 100, leading: 8, bottom: 40, trailing: 8) }
  static var slackButtonSize: CGSize { return CGSize(width: 200, height: 150) }
}

public struct LoginView: View {
  private let viewModel: LoginViewModel
  let sm: LoginManager = SlackManagerImpl(presentationAnchor: UIApplication.shared.windows[0])

  
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
      self.sm.login(result: { user in
        let userId = user?.get(key: "id") as? String ?? ""
        Action.Late.fromNow(value: "6_h", sender: userId, onSuccess: { result in print(result) }, onError: { error in print(error) })
      })
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
