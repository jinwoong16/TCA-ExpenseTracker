//
//  Dummy.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI

import ComposableArchitecture

struct Parent: ReducerProtocol {
  struct State: Equatable {
    var child: Child.State
  }
  
  enum Action: Equatable {
    case child(Child.Action)
    case buttonTapped
  }
  
  var body: some ReducerProtocol<State,Action> {
    Scope(state: \.child, action: /Action.child) {
      Child()
    }
    Reduce { state, action in
      switch action {
        case .child:
          print("child")
          return .none
          
        case .buttonTapped:
          print("button tapped")

          return state.child.update().map(Action.child)
      }
    }
  }
}

struct Child: ReducerProtocol {
  struct State: Equatable {
    var text: String = ""
  }
  enum Action: Equatable {
    case didPressButton
  }
  
  var body: some ReducerProtocol<State,Action> {
    Reduce { state, action in
      switch action {
        case .didPressButton:
          print("dddddd")
          state.text = ""// do validation or api calls etc. that is related to the Childs Domain
          return .none
      }
    }
  }
}

extension Child.State {
  func update() -> EffectTask<Child.Action> {
    print("update")
    return .run { send in
      await send(.didPressButton)
    }
  }
}

struct Dummy: View {
  let store: StoreOf<Parent>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Button(action: {
//        viewStore.send(.child(.update))
        viewStore.send(.buttonTapped)
        // or..
//        viewStore.send(.didPressButton) // in the reducer return Effect(value: .child(.update))
      }, label: {
        Text("Trigger Child Action")
      })
    }
  }
}






struct Dummy_Previews: PreviewProvider {
  static var previews: some View {
    Dummy(
      store: Store(
        initialState: Parent.State(child: Child.State()),
        reducer: Parent()
      )
    )
  }
}
