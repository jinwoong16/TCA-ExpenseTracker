//
//  RecentTransactionListFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/19.
//

import Foundation
import ComposableArchitecture

struct RecentTransactionListFeature: ReducerProtocol {
    struct State: Equatable {
        var transactionList: IdentifiedArrayOf<Transaction>
    }
    enum Action: Equatable {
        case empty
    }
    
    var body: some ReducerProtocolOf<Self> {
        EmptyReducer()
    }
}
