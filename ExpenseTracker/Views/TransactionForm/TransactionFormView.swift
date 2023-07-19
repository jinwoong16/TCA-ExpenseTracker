//
//  TransactionFormView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/20.
//

import SwiftUI
import ComposableArchitecture

struct TransactionFormView: View {
    let store: StoreOf<TransactionFormFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                Form {
                    Section {
                        TextField(
                            "Merchant",
                            text: viewStore.$transaction.merchant
                        )
                        CategoryPicker(
                            selection: viewStore.$transaction.category
                        )
                        TextField(
                            "Amount",
                            value: viewStore.$transaction.amount,
                            formatter: NumberFormatter()
                        )
                        .keyboardType(.decimalPad)
                        DatePicker(
                            "Date",
                            selection: viewStore.$transaction.date,
                            displayedComponents: [.date]
                        )
                        ExpenseTypeSegmentView(
                            type: viewStore.$transaction.type
                        )
                    } header: {
                        Text("Transaction Info")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            viewStore.send(.cancelButtonTapped)
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            viewStore.send(.addButtonTapped)
                        }
                    }
                }
            }
        }
    }
}

struct TransactionFormView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFormView(
            store: Store(
                initialState: TransactionFormFeature.State(
                    transaction: .emptyMock
                )
            ) {
                TransactionFormFeature()
            }
        )
    }
}
