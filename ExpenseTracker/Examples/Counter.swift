//
//  Counter.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI

import ComposableArchitecture

struct Counter: ReducerProtocol {
  struct State: Equatable {
    var count = 0
  }

  enum Action: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
  }

  func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .decrementButtonTapped:
      state.count -= 1
      return .none
    case .incrementButtonTapped:
      state.count += 1
      return .none
    }
  }
}

// MARK: - Feature view

struct CounterView: View {
  let store: StoreOf<Counter>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      HStack {
        Button {
          viewStore.send(.decrementButtonTapped)
        } label: {
          Image(systemName: "minus")
        }

        Text("\(viewStore.count)")
          .monospacedDigit()

        Button {
          viewStore.send(.incrementButtonTapped)
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

struct CounterDemoView: View {
  let store: StoreOf<Counter>

  var body: some View {
    Form {
      Section {
        CounterView(store: self.store)
          .frame(maxWidth: .infinity)
      }
    }
    .buttonStyle(.borderless)
    .navigationTitle("Counter demo")
  }
}

// MARK: - SwiftUI previews

struct CounterView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CounterDemoView(
        store: Store(initialState: Counter.State()) {
          Counter()
        }
      )
    }
  }
}
