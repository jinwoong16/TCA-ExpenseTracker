//
//  RecentTransactionListView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/19.
//

import SwiftUI
import ComposableArchitecture

struct RecentTransactionListView: View {
    let transactionList: IdentifiedArrayOf<Transaction>
    
    var body: some View {
        VStack {
            if transactionList.isEmpty {
                Text("There is no transaction yet.")
                    .frame(maxWidth: .infinity)
            }
            ForEach(
                Array(transactionList
                    .prefix(5)
                    .enumerated()),
                id: \.element
            ) { index, transaction in
                TransactionRow(transaction: transaction)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecentTransactionListView(
                transactionList: [.shoppingMock]
            )
        }
    }
}
