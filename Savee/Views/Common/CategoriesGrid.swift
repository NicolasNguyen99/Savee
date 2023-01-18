//
//  CategoriesGrid.swift
//  Savee
//
//  Created by Nicolas Nguyen on 11.01.2023.
//

import SwiftUI
import RealmSwift

struct CategoriesGrid: View {
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Category.self) var categories
    @State var filteringCriterium: TransactionType
    
    var onClick: (Category, ObjectId) -> Void
    
    let threeColumnGrid = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid, alignment: HorizontalAlignment.leading) {
                ForEach(categories.filter { $0.transactionType == filteringCriterium.title }) { category in
                    VStack {
                        IconCircle(backgroundColor: Color(cgColor: UIColor(category.color).cgColor), iconName: category.icon, imageSize: 35, circleSize: 45)
                        
                        Text("\(category.title)")
                            .font(.caption)
                    }
                    .frame(width: 80, height: 80)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onClick(category, category._id)
                        dismiss()
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}
