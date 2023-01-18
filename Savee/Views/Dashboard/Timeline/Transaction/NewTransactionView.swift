//
//  NewTransactionView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import SwiftUI
import RealmSwift

struct NewTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.realm) var realm
    
    @ObservedRealmObject var transaction: Transaction
    @ObservedResults(Category.self) var categories

    @State var shouldShowCategoryMenu: Bool = false
    @State var navigateToCreatingCattegory: Bool = false
    @State var shouldShowAlert: Bool = false
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var isUpdating: Bool {
        transaction.realm != nil
    }
    
    init(transaction: Transaction, shouldShowCategoryMenu: Bool, navigateToCreatingCattegory: Bool, shouldShowAlert: Bool) {
        self.transaction = transaction
        self.shouldShowCategoryMenu = shouldShowCategoryMenu
        self.navigateToCreatingCattegory = navigateToCreatingCattegory
        self.shouldShowAlert = shouldShowAlert
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        if transaction.categoryId == nil {
                            Button {
                                shouldShowCategoryMenu = true
                            } label: {
                                ZStack {
                                    Circle()
                                        .stroke(Color.white, style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .frame(width: 50, height: 50)
                                }
                            }
                        } else {
                            Button {
                                shouldShowCategoryMenu = true
                            } label: {
                                IconCircle(
                                    backgroundColor: Color(cgColor: UIColor(transaction.color).cgColor),
                                    iconName: transaction.icon,
                                    imageSize: 45,
                                    circleSize: 55
                                )
                            }
                            
                        }
                        
                        Spacer()
                        HStack(alignment: .center) {
                            TextField("0", value: $transaction.amount, formatter: formatter)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 30))
                                .accentColor(.white)
                            Text("CZK")
                        }
                    }
                }
                .padding()
                .frame(height: 100)
                .background(Color("saveeBlue"))
                .foregroundColor(Color(.white))
                
                VStack {
                    VStack {
                        IconInputField(name: "Title", image: "pencil", variable: $transaction.transactionTitle)
                        IconInputField(name: "Description", image: "note.text", variable: $transaction.note)
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    
                    DatePicker(selection: $transaction.date, displayedComponents: .date) {
                        
                        Text("Select a date")
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        addTransaction()
                    } label: {
                        Text(isUpdating ? "Save transaction" : "Add transaction")
                            .myWideButtonStyle()
                    }
                    .buttonStyle(.plain)
                }
            }
            .alert("Do you want to delete transaction?", isPresented: $shouldShowAlert) {
                Button("Delete", role: .destructive) {
                    try! realm.write {
                        realm.delete(realm.objects(Transaction.self).filter("_id=%@", transaction._id))
                    }
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                        .foregroundColor(Color.white)
                }
                
                if isUpdating {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            shouldShowAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            .navigationTitle(Text(isUpdating ? "Edit transaction" : "Add transaction"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            shouldShowCategoryMenu = transaction.icon == ""
        }
        .sheet(isPresented: $navigateToCreatingCattegory, content: {
                NewCategoryView(category: Category())
        })
        .sheet(isPresented: $shouldShowCategoryMenu) {
            CategoryMenuView(
                shouldOpenCreatingCattegory: $navigateToCreatingCattegory,
                categoryTitle: $transaction.categoryTitle,
                categoryIcon: $transaction.icon,
                categoryColor: $transaction.color,
                transactionType: $transaction.transactionType,
                categoryId: $transaction.categoryId
            )
        }
    }
}

extension NewTransactionView {
    func addTransaction() {
        if !isUpdating {
            if let ownerId = app.currentUser?.id {
                transaction.ownerId = ownerId
            }
            
            try? realm.write {
                realm.add(transaction)
            }
        }
        
        dismiss()
    }
}
