//
//  MainView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    RecentTransactionListView(
                        store: self.store.scope(
                            state: \.transactions,
                            action: { .transactions($0) }
                        )
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
        } destination: { state in
            switch state {
                case .transactionList:
                    CaseLet(
                        state: /MainFeature.Path.State.transactionList,
                        action: MainFeature.Path.Action.transactionList,
                        then: TransactionListView.init(store:)
                    )
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: MainFeature.State()
            ) {
                MainFeature()
            }
        )
    }
}
