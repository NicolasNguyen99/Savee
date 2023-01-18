//
//  CategoryMenuVIew.swift
//  Savee
//
//  Created by Nicolas Nguyen on 07.01.2023.
//

import SwiftUI
import RealmSwift

struct CategoryMenuView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var shouldOpenCreatingCattegory: Bool
    @Binding var categoryTitle: String
    @Binding var categoryIcon: String
    @Binding var categoryColor: String
    @Binding var transactionType: String
    @Binding var categoryId: ObjectId?

    
    @State var currentTab: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 10)

            HStack {
                Text("Transaction category")
                    .header3TextStyle()
                Spacer()
                IconCircle(backgroundColor: Color.gray, iconName: "plus", imageSize: 15, circleSize: 28)
                }
                .onTapGesture {
                    shouldOpenCreatingCattegory = true
                    dismiss()
                }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            
            VStack {
                TabBarView(currentTab: self.$currentTab)
                Spacer()
                    .frame(height: 10)
                TabView(selection: self.$currentTab) {
                    CategoriesGrid(
                        filteringCriterium: TransactionType.expense,
                        onClick: {
                            category , id  in do {
                                categoryTitle = category.title;
                                categoryIcon = category.icon;
                                categoryColor = category.color;
                                transactionType = category.transactionType;
                            }; categoryId = id
                            
                        }
                    )
                    .tag(0)
                    
                    CategoriesGrid(
                        filteringCriterium: TransactionType.income,
                        onClick: {
                            category , id  in do {
                                categoryTitle = category.title;
                                categoryIcon = category.icon;
                                categoryColor = category.color;
                                transactionType = category.transactionType;
                            }; categoryId = id
                            
                        }
                    )
                        .tag(1)
                    
                    CategoriesGrid(
                        filteringCriterium: TransactionType.investment,
                        onClick: {
                            category , id  in do {
                                categoryTitle = category.title;
                                categoryIcon = category.icon;
                                categoryColor = category.color;
                                transactionType = category.transactionType;
                            }; categoryId = id
                            
                        }
                    )
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .presentationDetents([.fraction(0.43)])
                .presentationDragIndicator(.visible)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
