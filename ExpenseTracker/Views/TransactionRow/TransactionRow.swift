//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by jinwoong Kim on 2023/07/12.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: transaction.category.icon.rawValue)
                        .font(.system(size: 24))
                        .foregroundColor(.icon)
                }
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transcaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction Category
                Text(transaction.category.name)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                // MARK: Transaction Date
                Text(transaction.date, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            // MARK: Transaction Amount
            Text(transaction.amount, format: .currency(code: "KRW"))
                .bold()
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(
            transaction: transactions[0]
        )
        .previewLayout(.sizeThatFits)
    }
}
