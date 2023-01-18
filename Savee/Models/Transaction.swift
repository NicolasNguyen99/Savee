//
//  Transaction.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import Foundation
import RealmSwift

class Transaction: Object, ObjectKeyIdentifiable, Comparable {
    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.date < rhs.date
    }
    
    static func > (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.date > rhs.date
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var ownerId: String = ""
    @Persisted var date: Date = Date.now
    @Persisted var amount: Double = 0.0
    @Persisted var transactionTitle: String = ""
    @Persisted var note: String = ""
    @Persisted var categoryTitle: String = ""
    @Persisted var icon: String = ""
    @Persisted var color: String = ""
    @Persisted var transactionType: String = TransactionType.expense.title
    @Persisted var categoryId: ObjectId? = nil
}
