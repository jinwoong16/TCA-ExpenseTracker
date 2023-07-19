//
//  InventoryFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/13.
//

import SwiftUI

import ComposableArchitecture

struct Item: Identifiable, Equatable {
  let id: Int
  let name: String
}

struct InventoryFeature: ReducerProtocol {
  struct State: Equatable {
    @PresentationState var addItem: ItemFormFeature.State?
    var items: IdentifiedArrayOf<Item> = [Item(id: 1, name: "test")]
  }
  
  enum Action: Equatable {
    case addItem(PresentationAction<ItemFormFeature.Action>)
    case addButtonTapped
  }
  
  var body: some ReducerProtocolOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
        case .addButtonTapped:
          state.addItem = ItemFormFeature.State()
          return .none
        
        case .addItem(.presented(.addButtonTapped)):
          state.items.append(Item(id: state.addItem?.id ?? 0, name: state.addItem?.name ?? "none"))
          return .none
          
        case .addItem:
          return .none
      }
    }
    .ifLet(\.$addItem, action: /Action.addItem) {
      ItemFormFeature()
    }
  }
}

struct InventoryView: View {
  let store: StoreOf<InventoryFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      List {
        ForEach(viewStore.state.items) { item in
          Text(item.name)
        }
        
        Button("Add") {
          viewStore.send(.addButtonTapped)
        }
        
        Button("Is nil??") {
          print(viewStore.addItem ?? "nil")
        }
      }
      .sheet(
        store: self
          .store
          .scope(
            state: \.$addItem,
            action: { .addItem($0) })
      ) { store in
        ItemFormView(store: store)
      }
    }
  }
}

struct InventoryView_Previews: PreviewProvider {
  static var previews: some View {
    InventoryView(
      store: Store(
        initialState: InventoryFeature.State(),
        reducer: InventoryFeature()
      )
    )
  }
}
