//
//  TransactionListView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI
import ComposableArchitecture

struct TransactionListView: View {
    let store: StoreOf<TransactionListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.transactions) { viewStore in
            List {
                ForEach(
                    Array(
                        viewStore
                            .state
                            .groupTransactionsByMonth()
                    ),
                    id: \.key
                ) { month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            TransactionRow(transaction: transaction)
                                .swipeActions {
                                    Button("Delete") {
                                        viewStore.send(.deleteTransactionTapped(id: transaction.id))
                                    }
                                }
                        }
                    } header: {
                        Text(month)
                    }
                }
            }
            .animation(.default, value: viewStore.state)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                Button {
                    viewStore.send(.addTransactionButtonTapped)
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.icon)
                }
            }
            .alert(
                store: self.store.scope(
                    state: \.$destination,
                    action: { .destination($0) }
                ),
                state: /TransactionListFeature.Destination.State.alert,
                action: TransactionListFeature.Destination.Action.alert
            )
            .sheet(
                store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                state: /TransactionListFeature.Destination.State.add,
                action: TransactionListFeature.Destination.Action.add
            ) { store in
                TransactionFormView(store: store)
                    .presentationDetents([.medium])
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TransactionListView(
                store: Store(
                    initialState: TransactionListFeature.State(
                        transactions: [
                            .shoppingMock,
                            .transportMock
                        ]
                    )
                ) {
                    TransactionListFeature()
                }
            )
        }
    }
}
