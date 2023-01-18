//
//  SectionHeader.swift
//  Savee
//
//  Created by Nicolas Nguyen on 07.01.2023.
//

import Foundation
import SwiftUI

struct CustomHeader: View {
    var date: String
    var value: String

    var body: some View {
        HStack {
            Text(date)
            Spacer()
            Text(value)
        }
        .padding()
        .background(Color("lightGray"))
    }
}
