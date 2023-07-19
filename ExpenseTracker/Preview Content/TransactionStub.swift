//
//  TransactionStub.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import Foundation

var transaction = Transaction(
  id: UUID(),
  merchant: "GS25",
  category: .shopping,
  amount: 2000.0,
  type: .debit,
  date: Date()
)

var transactions = [Transaction](repeating: transaction, count: 10)
