//
//  MyPicker.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/20.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

struct MyPicker: View {
    @State private var selectedFlavor: Flavor = .chocolate
    
    var body: some View {
        Picker("Flavor", selection: $selectedFlavor) {
            ForEach(Flavor.allCases) { flavor in
                Text(flavor.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct MyPicker_Previews: PreviewProvider {
    static var previews: some View {
        MyPicker()
    }
}
