//
//  OKAlert.swift
//  UI
//
//  Created by Bohdan Savych on 8/1/19.
//  Copyright © 2019 Bohdan Savych. All rights reserved.
//

import SwiftUI

public final class AlertProducer {
  static func getOkAlert(title: String, message: String) -> Alert {
    Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("Ok")))
  }
}
