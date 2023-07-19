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
        var transaction: IdentifiedArrayOf<Transaction>
    }
    enum Action: Equatable {}
    
    var body: some ReducerProtocolOf<Self> {
        EmptyReducer()
    }
}
