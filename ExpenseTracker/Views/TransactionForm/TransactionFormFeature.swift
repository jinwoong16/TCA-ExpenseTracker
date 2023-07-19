//
//  TransactionFormFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/20.
//

import Foundation
import ComposableArchitecture

struct TransactionFormFeature: ReducerProtocol {
    struct State: Equatable {
        @BindingState var transaction: Transaction
    }
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case addButtonTapped
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case saveTransaction(Transaction)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerProtocolOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .cancelButtonTapped:
                    return .run { _ in await self.dismiss() }
                    
                case .addButtonTapped:
                    return .run { [transaction = state.transaction] send in
                        await send(.delegate(.saveTransaction(transaction)))
                        await self.dismiss()
                    }
                    
                case .delegate:
                    return .none
                    
                case .binding:
                    return .none
            }
        }
    }
}
