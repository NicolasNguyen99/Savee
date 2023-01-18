//
//  TransactionType.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import Foundation
import RealmSwift

enum TransactionType: String, CaseIterable, PersistableEnum {
    case expense
    case income
    case transfer
    case investment
    
    var title: String {
        switch self {
            case .expense: return "expense"
            case .income: return "income"
            case .transfer: return "transfer"
            case .investment: return "investment"
        }
    }
}
