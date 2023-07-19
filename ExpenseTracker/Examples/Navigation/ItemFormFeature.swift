//
//  ItemFormFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/13.
//

import SwiftUI

import ComposableArchitecture

struct ItemFormFeature: ReducerProtocol {
  struct State: Equatable {
    @BindingState var name: String = ""
    @BindingState var id: Int = 0
  }
  
  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case addButtonTapped
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerProtocolOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
        case .binding:
          return .none
          
        case .addButtonTapped:
          return .run { _ in await self.dismiss() }
      }
    }
  }
}

struct ItemFormView: View {
  let store: StoreOf<ItemFormFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
        TextField("id", value: viewStore.$id, format: .number)
        TextField("name", text: viewStore.$name)
        Button("add") {
          viewStore.send(.addButtonTapped)
        }
      }
    }
  }
}

struct ItemFormView_Previews: PreviewProvider {
  static var previews: some View {
    ItemFormView(
      store: Store(
        initialState: ItemFormFeature.State(),
        reducer: ItemFormFeature()
      )
    )
  }
}
