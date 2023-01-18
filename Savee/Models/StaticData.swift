//
//  StaticData.swift
//  Savee
//
//  Created by Nicolas Nguyen on 12.01.2023.
//

import Foundation

let fixedCategories = [
    //Expenses fixed categories
    Category(ownerId: app.currentUser?.id ?? "", title: "Education", icon: "graduationcap.fill", color: "#206de8", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Travel", icon: "airplane", color: "#3e68ab", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Electronic", icon: "bolt.fill", color: "#1a92ad", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Groceries", icon: "cart.fill", color: "#4ddba9", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Gifts", icon: "gift.fill", color: "#18de29", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Car", icon: "car.fill", color: "#b1e346", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Transport", icon: "tram.fill", color: "#d97630", transactionType: TransactionType.expense.title),
    Category( ownerId: app.currentUser?.id ?? "", title: "Other", icon: "questionmark.folder.fill", color: "#9e2e20", transactionType: TransactionType.expense.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Home", icon: "house.fill", color: "#901d96", transactionType: TransactionType.expense.title),
    
    //Incomes fixed categories
    Category(ownerId: app.currentUser?.id ?? "", title: "Salary", icon: "banknote.fill", color: "#0e5c08", transactionType: TransactionType.income.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Other", icon: "questionmark.folder.fill", color: "#a4d685", transactionType: TransactionType.income.title),
    Category(ownerId: app.currentUser?.id ?? "", title: "Gifts", icon: "giftcard.fill", color: "#6d9157", transactionType: TransactionType.income.title),
]

let iconsCategory = [
    CategoryIcon(icon: "flame.fill"),
    CategoryIcon(icon: "drop.fill"),
    CategoryIcon(icon: "infinity.circle.fill"),
    CategoryIcon(icon: "flag.2.crossed.fill"),
    CategoryIcon(icon: "icloud.fill"),
    CategoryIcon(icon: "camera.fill"),
    CategoryIcon(icon: "phone.fill"),
    CategoryIcon(icon: "wallet.pass.fill"),
    CategoryIcon(icon: "cart.fill"),
    CategoryIcon(icon: "bag.fill"),
    CategoryIcon(icon: "giftcard.fill"),
    CategoryIcon(icon: "die.face.6.fill"),
    CategoryIcon(icon: "bandage.fill"),
    CategoryIcon(icon: "hammer.fill"),
    CategoryIcon(icon: "stethoscope"),
    CategoryIcon(icon: "cross.case.fill"),
    CategoryIcon(icon: "theatermasks.fill"),
    CategoryIcon(icon: "building.columns.fill"),
    CategoryIcon(icon: "car.fill"),
    CategoryIcon(icon: "airplane"),
    CategoryIcon(icon: "airplane.departure"),
]

class CategoryIcon: Identifiable {
    let id: UUID = UUID()
    var icon: String = ""
    
    init(icon: String) {
        self.icon = icon
    }
}
