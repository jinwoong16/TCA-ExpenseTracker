//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/11.
//

import SwiftUI

extension Color {
  static let background = Color("Background")
  static let icon = Color("Icon")
  static let text = Color("Text")
  static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
  static let allNumericUSA: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    
    return formatter
  }()
}
