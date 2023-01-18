//
//  TransactionRow.swift
//  Savee
//
//  Created by Nicolas Nguyen on 07.01.2023.
//

import SwiftUI
import RealmSwift

struct TransactionRow: View {
    @ObservedRealmObject var transaction: Transaction
    @ObservedResults(Category.self) var categories
    
    @State var shouldShowSheet: Bool = false
    
    var body: some View {
         HStack{
             IconCircle(
                backgroundColor: Color(cgColor: UIColor(transaction.color).cgColor),
                iconName: "\(transaction.icon)",
                imageSize: 25,
                circleSize: 35
             )
            
            VStack {
                HStack {
                    Text(transaction.transactionTitle)
                    Spacer()
                }
                
                if transaction.note != "" {
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundColor(Color("lightGray"))
                        Text(transaction.note)
                            .footNoteTextStyle()
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()
            
             VStack(alignment: .trailing) {
                 Text(transfortDate())
                     .footNoteWTextStyle()
                     .lineLimit(1)
                 
                 
                 switch transaction.transactionType {
                 case TransactionType.transfer.title:
                     Text("\(transaction.amount, specifier: "%.2f") CZK")
                 case TransactionType.expense.title:
                     Text("-\(transaction.amount, specifier: "%.2f") CZK")
                         .foregroundColor(.red)
                 case TransactionType.income.title:
                     Text("+\(transaction.amount, specifier: "%.2f") CZK")
                         .foregroundColor(.green)
                 case TransactionType.investment.title:
                     Text("\(transaction.amount, specifier: "%.2f") CZK")
                         .foregroundColor(Color("saveeBlue"))
                 default:
                     Text("")
                 }
             }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            openUpdateTransaction()
        }
        .sheet(isPresented: $shouldShowSheet){
            NewTransactionView(
                transaction: transaction
            )
        }
    }
}

extension TransactionRow {
    func transfortDate() -> String {
        return "\(transaction.date.formatted(.dateTime.weekday().day()))"
    }
    
    func openUpdateTransaction() {
        shouldShowSheet.toggle()
    }
}
