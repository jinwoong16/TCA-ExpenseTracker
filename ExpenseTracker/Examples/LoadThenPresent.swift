//
//  LoadThenPresent.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI

import ComposableArchitecture

struct LoadThenPresent: ReducerProtocol {
  struct State: Equatable {
    @PresentationState var counter: Counter.State?
    var isActivityIndicatorVisible = false
    var setOfNumber: [Int] = []
  }

  enum Action {
    case counter(PresentationAction<Counter.Action>)
    case counterButtonTapped
    case counterPresentationDelayCompleted
  }

  @Dependency(\.continuousClock) var clock

  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .counter:
        return .none

      case .counterButtonTapped:
        state.isActivityIndicatorVisible = true
        return .run { send in
          try await self.clock.sleep(for: .seconds(1))
          await send(.counterPresentationDelayCompleted)
        }

      case .counterPresentationDelayCompleted:
        state.isActivityIndicatorVisible = false
        state.counter = Counter.State()
        return .none

      }
    }
    .ifLet(\.$counter, action: /Action.counter) {
      Counter()
    }
  }
}

// MARK: - Feature view

struct LoadThenPresentView: View {
  let store: StoreOf<LoadThenPresent>

  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
        Button {
          viewStore.send(.counterButtonTapped)
        } label: {
          HStack {
            Text("Load optional counter")
            if viewStore.isActivityIndicatorVisible {
              Spacer()
              ProgressView()
            }
          }
        }
      }
      .sheet(
        store: store.scope(state: \.$counter, action: LoadThenPresent.Action.counter),
        content: CounterView.init(store:)
      )
      .navigationTitle("Load and present")
    }
  }
}

// MARK: - SwiftUI previews

struct LoadThenPresentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoadThenPresentView(
        store: Store(initialState: LoadThenPresent.State()) {
          LoadThenPresent()
        }
      )
    }
  }
}
