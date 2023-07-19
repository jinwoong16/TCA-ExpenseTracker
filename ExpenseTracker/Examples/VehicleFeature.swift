//
//  VehicleFeature.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import ComposableArchitecture
import SwiftUI

struct Vehicle: Equatable {}

struct VehicleFeature: ReducerProtocol {
  struct State: Equatable {
    var addVehicle: NewVehicle.State = NewVehicle.State()
    var isAddVehicleSheetPresented = false
    var vehicles: [String] = []
  }
  enum Action: Equatable {
    case addVehicle(NewVehicle.Action)
    case addNewVehicleButtonPressed
    case setAddVehicleSheet(isPresented: Bool)
  }
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.addVehicle, action: /Action.addVehicle) {
      NewVehicle()
    }
    Reduce { state, action in
      switch action {
        case .setAddVehicleSheet(isPresented: true):
          state.isAddVehicleSheetPresented = true
          return .none
        case .setAddVehicleSheet(isPresented: false):
          state.isAddVehicleSheetPresented = false
          return .none
        case .addNewVehicleButtonPressed:
          state.addVehicle = NewVehicle.State()
          return .none
          //### How do these cases get called from the child?
        case .addVehicle(.addButtonTapped):
          state.isAddVehicleSheetPresented = false
          state.vehicles.append(state.addVehicle.vin)
          
          return state.addVehicle.flush().map(Action.addVehicle)
        case .addVehicle(.vinChanged(_)):
          return .none
          //###
      }
    }
  }
}

struct VehicleFeatureView: View {
  let store: StoreOf<VehicleFeature>
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      NavigationStack {
        Form {
          Section("Vehicles") {
            Button(action: { viewStore.send(.setAddVehicleSheet(isPresented: true)) }) {
              Text("Add new vehicle")
            }
            .sheet(
              isPresented: viewStore.binding(
                get: \.isAddVehicleSheetPresented,
                send: VehicleFeature.Action.setAddVehicleSheet(isPresented:)
              )
            ) {
//              NewVehicleView(store: Store(
//                initialState: NewVehicle.State(),
//                reducer: NewVehicle()
//              ))
              
              NewVehicleView(
                store: self.store.scope(
                  state: \.addVehicle,
                  action: VehicleFeature.Action.addVehicle
                )
              )
            }
            .navigationTitle("Vehicle Feature")
            
            Button("home!") {
              print(viewStore.state.vehicles)
            }
          }
        }
        
      }
      
      
    }
  }
}

struct VehicleFeatureView_Previews: PreviewProvider {
  static var previews: some View {
    VehicleFeatureView(
      store: Store(
        initialState: VehicleFeature.State(),
        reducer: VehicleFeature()
      )
    )
  }
}
