//
//  ExpenseTypeSegmentView.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/20.
//

import SwiftUI

struct ExpenseTypeSegmentView: View {
    @Binding var type: TransactionType
    
    var body: some View {
        Picker("Debit/Credit", selection: self.$type) {
            ForEach(TransactionType.allCases) { type in
                Text(type.rawValue.capitalized)
                    .tag(type)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ExpenseTypeSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseTypeSegmentView(
            type: .constant(.debit)
        )
    }
}
