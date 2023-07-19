//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/11.
//

import SwiftUI

import ComposableArchitecture

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(
                store: Store(
                    initialState: MainFeature.State()
                ) {
                    MainFeature()
                        ._printChanges()
                }
            )
        }
    }
}
