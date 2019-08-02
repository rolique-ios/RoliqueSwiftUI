//
//  LoginView.swift
//  ROLIQUE
//
//  Created by Bohdan Savych on 7/31/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

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
  
  @State private var showingAlert = false
  @State var error: Error? = nil
  @State var pushActive = false
  
  public init(viewModel: LoginViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    NavigationView {
        MasterView(onSlackButtonPress: self.viewModel.login, pushActive: self.$pushActive)
          .navigationBarTitle(String())
          .navigationBarHidden(true)
          .alert(isPresented: self.$showingAlert, content: toClosure(AlertProducer.getOkAlert(title: Strings.General.appName, message: self.error?.localizedDescription ?? "")))
          .onReceive(self.viewModel.onError, perform: self.handleError(_:))
          .onReceive(self.viewModel.onSuccessLogin, perform: self.handleSuccessfullLogin)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

// MARK: - Binding
private extension LoginView {
  func handleSuccessfullLogin() {
    self.pushActive = true
    print("handleSuccessfullLogin")
  }
  
  func handleError(_ error: Error) {
    self.showingAlert = true
    self.error = error
    print("handleError")
  }
}

// MARK: - Private
private extension LoginView {
  struct MasterView: View {
    let onSlackButtonPress: () -> Void
    let pushActive: Binding<Bool>
    
    var body: some View {
      ZStack {
        Colors.Login.backgroundColor.edgesIgnoringSafeArea(.all)
        VStack {
          Logo()
          Spacer()
          SlackButton(onPress: self.onSlackButtonPress, pushActive: pushActive)
          NavigationLink(destination: TabbarView(), isActive: self.pushActive) {
            Text("")
          }.hidden()
        }.padding(Constants.edgeInsets)
      }
    }
  }
  
  struct SlackButton: View {
    let onPress: () -> Void
    let pushActive: Binding<Bool>
    
    var body: some View {
      Button(action: {
        self.onPress()
      }) {
        Images.Login.slackButton
          .renderingMode(.original)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: Constants.slackButtonSize.width, height: Constants.slackButtonSize.height)
      }
    }
  }
  
  struct Logo: View {
    var body: some View {
      Images.Login.fullLogo
        .renderingMode(.original)
        .resizable()
        .frame(width: Constants.logoSize.width, height: Constants.logoSize.height)
        .padding(.all, 20)
        .border(Color.white, width: 1, cornerRadius: 5)
    }
  }
}
