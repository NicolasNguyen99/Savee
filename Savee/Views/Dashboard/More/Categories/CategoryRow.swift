//
//  CategoryRow.swift
//  Savee
//
//  Created by Nicolas Nguyen on 08.01.2023.
//

import SwiftUI
import RealmSwift

struct CategoryRow: View {
    @ObservedResults(Transaction.self) var transactions
    @ObservedRealmObject var category: Category
    @State var shouldShowSheet: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color(cgColor: UIColor(category.color).cgColor))
                    .frame(width: 35, height: 35)
                Image(systemName: "\(category.icon)")
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading) {
                Text("\(category.title)")
                Text("\(transactions.filter { $0.categoryTitle == category.title }.count ) transactions")
                    .footNoteTextStyle()
                    .padding(0)
            }
            Spacer()
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            openUpdateCategory()
        }
        .sheet(isPresented: $shouldShowSheet) {
            NewCategoryView(category: category)
        }
    }
}

extension CategoryRow {
    func openUpdateCategory() {
        shouldShowSheet.toggle()
    }
}
