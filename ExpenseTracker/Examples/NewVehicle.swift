//
//  NewVehicle.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import ComposableArchitecture
import SwiftUI

struct NewVehicle: ReducerProtocol {
  struct State: Equatable {
    var vin: String = ""
  }
  enum Action: Equatable {
    case vinChanged(String)
    case addButtonTapped
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
        case let .vinChanged(vin):
          state.vin = vin
          return .none
        case .addButtonTapped:
          print("in newvehicle: ", state.vin)
          return .none
      }
    }
  }
}

extension NewVehicle.State {
  mutating func flush() -> EffectTask<NewVehicle.Action> {
    
    vin = ""
    
    return .none
  }
}

struct NewVehicleView: View {
  @Environment(\.dismiss) var dismiss
  let store: StoreOf<NewVehicle>
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      Form {
        TextField(
          "VIN",
          text: viewStore.binding(get: \.vin, send: NewVehicle.Action.vinChanged)
        )
        Button("Add") {
          viewStore.send(.addButtonTapped)
//          dismiss() //Used to close sheet
        }
      }
    }
  }
}
struct NewVehicle_Previews: PreviewProvider {
  static var previews: some View {
    NewVehicleView(store: Store(initialState: NewVehicle.State(), reducer: NewVehicle()))
  }
}
