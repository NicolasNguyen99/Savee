//
//  QuoteDetail.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import Foundation

struct QuoteDetailRowColumnItem: Identifiable {
    let id = UUID()
    let rows: [RowItem]
    
    struct RowItem: Identifiable {
        
        let id = UUID()
        let title: String
        let value: String
    }
}
