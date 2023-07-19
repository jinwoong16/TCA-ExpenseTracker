//
//  RecentTransactionListView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/19.
//

import SwiftUI
import ComposableArchitecture

struct RecentTransactionListView: View {
    let store: StoreOf<RecentTransactionListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: \.transactionList) { viewStore in
            VStack {
                HStack {
                    Text("Recent Transactions")
                        .bold()
                    Spacer()
                    NavigationLink(
                        state: MainFeature.Path.State.transactionList(
                            TransactionListFeature.State(
                                transactions: viewStore.state
                            )
                        )
                    ) {
                        HStack {
                            Text("See All")
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                if viewStore.isEmpty {
                    Text("There is no transaction yet.")
                        .frame(maxWidth: .infinity)
                        .padding([.top])
                }
                ForEach(viewStore.state.prefix(5)) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
            .padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
        }
    }
}

struct RecentTransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecentTransactionListView(
                store: Store(
                    initialState: RecentTransactionListFeature.State(
                        transactionList: [.shoppingMock]
                    )
                ) {
                    RecentTransactionListFeature()
                }
            )
        }
    }
}
