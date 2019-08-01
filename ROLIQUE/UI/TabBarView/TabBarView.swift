//
//  TabBarView.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
  @State var selectedTab = Tab.profile
  
  enum Tab: Int {
    case profile, stats
  }
  
  func tabbarItem(text: String, image: String) -> some View {
    VStack {
      Image(systemName: image)
        .imageScale(.large)
      Text(text)
    }
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ProfileView(viewModel: ProfileViewModelImpl()).tabItem {
        self.tabbarItem(text: "Profile", image: "profile").tag(Tab.profile)
      }
      StatsView(viewModel: StatsViewModelImpl()).tabItem {
        self.tabbarItem(text: "Stats", image: "stats").tag(Tab.stats)
      }
    }
    .edgesIgnoringSafeArea(.top)
  }
}
