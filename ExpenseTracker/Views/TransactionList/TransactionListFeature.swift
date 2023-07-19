//
//  TransactionListFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/19.
//

import Foundation
import ComposableArchitecture

struct TransactionListFeature: ReducerProtocol {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var transactions: IdentifiedArrayOf<Transaction> = []
    }
    enum Action: Equatable {
        case destination(PresentationAction<Destination.Action>)
        case deleteTransactionTapped(id: Transaction.ID)
        case addTransactionButtonTapped
    }
    
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
                case let .deleteTransactionTapped(id):
                    state.destination = .alert(.deleteTransaction(id: id))
                    return .none
                    
                case let .destination(.presented(.alert(.confirmDeletion(id)))):
                    state.transactions.remove(id: id)
                    state.destination = nil
                    return .none
                    
                case let .destination(.presented(.add(.delegate(.saveTransaction(transaction))))):
                    state.transactions.append(transaction)
                    state.destination = nil
                    return .none
                    
                case .addTransactionButtonTapped:
                    state.destination = .add(
                        TransactionFormFeature.State(
                            transaction: .empty(uuid())
                        )
                    )
                    return .none
                    
                case .destination:
                    return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}

extension TransactionListFeature {
    struct Destination: ReducerProtocol {
        enum State: Equatable {
            case alert(AlertState<Action.Alert>)
            case add(TransactionFormFeature.State)
        }
        enum Action: Equatable {
            case alert(Alert)
            case add(TransactionFormFeature.Action)
            
            enum Alert: Equatable {
                case confirmDeletion(id: Transaction.ID)
            }
        }
        
        var body: some ReducerProtocolOf<Self> {
            Scope(state: /State.add, action: /Action.add) {
                TransactionFormFeature()
            }
        }
    }
}

extension AlertState where Action == TransactionListFeature.Destination.Action.Alert {
    static func deleteTransaction(id: Transaction.ID) -> Self {
        Self {
            TextState("Delete?")
        } actions: {
            ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                TextState("Yes")
            }
            ButtonState(role: .cancel) {
                TextState("Cancel")
            }
        } message: {
            TextState("Are you sure you want to delete this transaction?")
        }
    }
}
