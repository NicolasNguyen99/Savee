//
//  ExpensesList.swift
//  Savee
//
//  Created by Nicolas Nguyen on 08.01.2023.
//

import SwiftUI
import RealmSwift

struct CategoriesList: View {
    @Environment(\.realm) var realm
    
    @ObservedResults(Category.self) var categories
    @State var filteringCriterium: TransactionType
    
    var body: some View {
        List {
            ForEach(categories.filter { $0.transactionType == filteringCriterium.title } ) { category in
                CategoryRow(category: category)
            }
            .onDelete(perform: $categories.remove)
        }
        .listStyle(.plain)
    }
}
