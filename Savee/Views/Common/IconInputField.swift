//
//  IconInputField.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import SwiftUI

struct IconInputField: View {
    let name: String
    let image: String
    @Binding var variable: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.system(size: 24))
            Spacer()
                .frame(width: 5)
            TextField(name, text: $variable)
                .frame(maxWidth: .infinity)
                .underlineTextField()
        }
        
    }
}

