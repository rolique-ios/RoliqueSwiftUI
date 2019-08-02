//
//  TabBarView.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI
import Utils

private struct Constants {
  static var tabItemSize: CGSize { return CGSize(width: 20, height: 20) }
}

public struct HomeView: View {
  public var body: some View {
    TabBarView()
  }
}

private struct TabBarView: View {
  @State var selectedTab = Tab.profile
  
  enum Tab: Int {
    case profile,
    stats
    
    var image: Image {
      switch self {
      case .profile:
        return Images.TabBar.profile
        
      case .stats:
        return Images.TabBar.stats
      }
    }
    
    var name: String {
      switch self {
      case .profile:
        return Strings.TabBar.profile.firstUppercased
      case .stats:
        return Strings.TabBar.stats.firstUppercased
      }
    }
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ProfileView(viewModel: ProfileViewModelImpl()).tabItem {
        self.tabbarItem(Tab.profile)
          .tag(Tab.profile)
      }
      StatsView(viewModel: StatsViewModelImpl()).tabItem {
        self.tabbarItem(Tab.stats)
          .tag(Tab.stats)
      }
    }
    .navigationBarBackButtonHidden(true)
    .edgesIgnoringSafeArea(.top)
  }
}

// MARK: - Private
private extension TabBarView {
  func tabbarItem(_ tab: Tab) -> some View {
    VStack {
      tab.image
        .resizable()
        .frame(width: Constants.tabItemSize.width, height: Constants.tabItemSize.height)
      Text(tab.name)
    }
  }
}
