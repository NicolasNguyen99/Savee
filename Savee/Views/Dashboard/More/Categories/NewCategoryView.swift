//
//  NewCategoryView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 08.01.2023.
//

import SwiftUI
import RealmSwift
import UIColorHexSwift

struct NewCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.realm) var realm
    
    @ObservedRealmObject var category: Category
    
    @State var shouldShowAlert: Bool = false
    @State var choosedColor: Color = Color.red
    @State var choosedCategoryIcon: String?
    
    var isUpdating: Bool {
        category.realm != nil
    }
    
    let fiveColumnGrid = [
        GridItem(.fixed(60)),
        GridItem(.fixed(60)),
        GridItem(.fixed(60)),
        GridItem(.fixed(60)),
        GridItem(.fixed(60)),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            IconCircle(backgroundColor: choosedColor, iconName: category.icon, imageSize: 45, circleSize: 55)
                            TextField("Category name", text: $category.title)
                                .frame(maxWidth: .infinity)
                        }
                        .task {
                            if category.color == "" {
                                choosedColor = Color.red
                            } else {
                                choosedColor = Color(cgColor: UIColor(category.color).cgColor)
                            }
                            print(category)
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

                        VStack {
                            Text("Choose category type")
                                .header3TextStyle()
                            Picker("Category type", selection: $category.transactionType) {
                                Text("Expense").tag(TransactionType.expense.title)
                                Text("Income").tag(TransactionType.income.title)
                                Text("Investment").tag(TransactionType.investment.title)
                            }
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                            .pickerStyle(.segmented)
                        }
                            
                        ColorPicker("Set color of category", selection: $choosedColor, supportsOpacity: false)
                            .header3TextStyle()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
                        
                        HStack {
                            Text("Choose category icon")
                                .header3TextStyle()
                            Spacer()
                        }
                        
                        LazyVGrid(columns: fiveColumnGrid, alignment: HorizontalAlignment.center) {
                            ForEach(iconsCategory) { category in
                                Button(action: {
                                    self.choosedCategoryIcon = category.icon
                                    
                                    if (isUpdating) {
                                        try! realm.write {
                                            self.category.thaw()?.icon = self.choosedCategoryIcon ?? ""
                                            print("Writen")
                                        }
                                    } else {
                                        self.category.icon = self.choosedCategoryIcon ?? ""
                                    }
                                }
                                 ) {
                                    IconCircle(
                                        backgroundColor: choosedCategoryIcon ?? "" == category.icon ? Color.gray : Color("lightGray"),
                                        iconName: category.icon,
                                        imageSize: 45,
                                        circleSize: 55
                                    )
                                }
                                .frame(width: 60, height: 60)
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                }
                Button {
                    addCategory()
                } label: {
                    Text(isUpdating ? "Save category" : "Create category")
                        .myWideButtonStyle()
                }
                .buttonStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                if isUpdating {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            shouldShowAlert = true
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .alert("Do you want to delete category?", isPresented: $shouldShowAlert) {
                Button("Delete", role: .destructive) {
                    try! realm.write {
                        realm.delete(realm.objects(Category.self).filter("_id=%@", category._id))
                    }
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
            .navigationTitle(Text(isUpdating ? "Edit category" : "Create a new category"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
        }
    }
}

extension NewCategoryView {
    func addCategory() {
        print(category)
        if (isUpdating) {
            try! realm.write {
                self.category.thaw()?.color = UIColor(choosedColor).hexString(false)
                print("Writen color")
            }
        } else {
            self.category.color = UIColor(choosedColor).hexString(false)
            print("Writen color")
        }
        
        if !isUpdating {
            if let ownerId = app.currentUser?.id {
                category.ownerId = ownerId
            }
            
            try? realm.write {
                realm.add(category)
            }
        }
        
        dismiss()
    }
}
