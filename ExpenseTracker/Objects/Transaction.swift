//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import Foundation
import IdentifiedCollections
import Collections

struct Transaction: Identifiable, Equatable, Hashable {
    let id: UUID
    var merchant: String
    var category: Category
    var amount: Double
    var type: TransactionType
    var date: Date
    
    var dateString: String {
        DateFormatter.allNumericUSA.string(from: date)
    }
}

enum TransactionType: String, Hashable, CaseIterable, Identifiable {
    case debit
    case credit
    
    var id: String {
        rawValue
    }
}

extension Transaction {
    static let shoppingMock = Self(
        id: UUID(),
        merchant: "GS25",
        category: .shopping,
        amount: 2000.0,
        type: .debit,
        date: Date().addingTimeInterval(-60*60*24*7)
    )
    static let transportMock = Self(
        id: UUID(),
        merchant: "KoreaAir",
        category: .transport,
        amount: 190000.0,
        type: .debit,
        date: Date()
    )
    static let emptyMock = Self(
        id: UUID(),
        merchant: "",
        category: .entertainment,
        amount: 0,
        type: .debit,
        date: Date()
    )
    
    static func empty(_ uuid: Transaction.ID) -> Self {
        Self(
            id: uuid,
            merchant: "",
            category: .entertainment,
            amount: 0,
            type: .credit,
            date: Date()
        )
    }
}

extension IdentifiedArray where Element == Transaction {
    func groupTransactionsByMonth() -> OrderedDictionary<String, [Transaction]> {
        guard !self.isEmpty else { return [:] }
        let groupedTransactions = OrderedDictionary(grouping: self) { $0.dateString }
        return groupedTransactions
    }
}
