//
//  CategoryPicker.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/20.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selection: Category
    
    var body: some View {
        Picker("Category", selection: self.$selection) {
            ForEach(CategoryEnum.allCases.map { $0.category }) { category in
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                    Label(
                        category.name,
                        systemImage: category.icon.rawValue
                    )
                    .padding()
                }
                .fixedSize()
                .tag(category)
            }
        }
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPicker(
            selection: .constant(.entertainment)
        )
    }
}
