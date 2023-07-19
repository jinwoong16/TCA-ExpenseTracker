//
//  Category.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI

struct Category: Identifiable, Equatable, Hashable {
  let id: Int
  let name: String
  let icon: Symbol
}

extension Category {
  static let transport = Category(id: 1, name: "Transport", icon: .transport)
  static let entertainment = Category(id: 2, name: "Entertainment", icon: .entertainment)
  static let shopping = Category(id: 3, name: "Shopping", icon: .shopping)
}

enum CategoryEnum: String, CaseIterable, Identifiable {
    case transport
    case entertainment
    case shopping
    
    var category: Category {
        switch self {
            case .transport:
                return .transport
            case .entertainment:
                return .entertainment
            case .shopping:
                return .shopping
        }
    }
    var id: String {
        rawValue
    }
}

enum Symbol: String {
    case transport = "bus"
    case entertainment = "film.stack.fill"
    case shopping = "cart.fill"
}
