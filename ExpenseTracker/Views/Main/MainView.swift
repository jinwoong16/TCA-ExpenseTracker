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
            WithViewStore(self.store, observe: \.transactions) { viewStore in
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Overview")
                            .font(.title2)
                            .bold()
                        HStack {
                            // MARK: Header Title
                            Text("Recent Transactions")
                                .bold()
                            Spacer()
                            NavigationLink(
                                state: MainFeature
                                    .Path
                                    .State
                                    .transactionList(
                                        TransactionListFeature.State(
                                            transactions: viewStore.state
                                        )
                                    )
                            ) {
                                HStack {
                                    Text("See All")
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.text)
                            }
                        }
                        RecentTransactionListView(transactionList: viewStore.state)
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            }
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
