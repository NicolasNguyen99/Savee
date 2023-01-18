//
//  CategoryOptions.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import Foundation
import RealmSwift

class Category: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var ownerId: String = ""
    @Persisted var title: String = ""
    @Persisted var icon: String = ""
    @Persisted var color: String = ""
    @Persisted var transactionType: String = TransactionType.expense.title
    
    override init() {
        super.init()
    }
    
    init(ownerId: String, title: String, icon: String, color: String, transactionType: String) {
        self.ownerId = ownerId
        self.title = title
        self.icon = icon
        self.color = color
        self.transactionType = transactionType
    }
    
}
