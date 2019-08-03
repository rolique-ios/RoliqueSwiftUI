//
//  TodayViewController.swift
//  VacationTodayExtension
//
//  Created by Bohdan Savych on 8/3/19.
//  Copyright © 2019 ROLIQUE. All rights reserved.
//

import UIKit
import NotificationCenter
import UsersWidget

final class TodayViewController: UsersViewController {
  override func loadData(usersCompletion: @escaping (([Userable]) -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      usersCompletion([])
    }
  }
}
