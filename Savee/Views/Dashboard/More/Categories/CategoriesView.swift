//
//  CategoriesView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 08.01.2023.
//

import SwiftUI
import RealmSwift

struct CategoriesView: View {
    @Environment(\.realm) var realm
    
    @ObservedResults(Category.self) var categories
    @State var currentTab: Int = 0
    @State var shouldOpenSheet: Bool = false
    
    var body: some View {
        Spacer()
            .frame(height: 10)
        VStack {
            TabBarView(currentTab: self.$currentTab)
            TabView(selection: self.$currentTab) {
                CategoriesList(filteringCriterium: TransactionType.expense)
                    .tag(0)
                
                CategoriesList(filteringCriterium: TransactionType.income)
                    .tag(1)
                
                CategoriesList(filteringCriterium: TransactionType.investment)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    shouldOpenSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $shouldOpenSheet){
            NewCategoryView(category: Category())
        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
}
