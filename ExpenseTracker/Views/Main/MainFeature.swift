//
//  MainFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/18.
//

import Foundation
import ComposableArchitecture

struct MainFeature: ReducerProtocol {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var transactions: IdentifiedArrayOf<Transaction> = []
    }
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
                case let .path(.popFrom(id)):
                    guard case let .transactionList(transactionState)? = state.path[id: id] else {
                        return .none
                    }
                    state.transactions = transactionState.transactions
                    return .none
                    
                case .path:
                    return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

extension MainFeature {
    struct Path: ReducerProtocol {
        enum State: Equatable {
            case transactionList(TransactionListFeature.State)
        }
        enum Action: Equatable {
            case transactionList(TransactionListFeature.Action)
        }
        
        var body: some ReducerProtocolOf<Self> {
            Scope(state: /State.transactionList, action: /Action.transactionList) {
                TransactionListFeature()
            }
        }
    }
}
