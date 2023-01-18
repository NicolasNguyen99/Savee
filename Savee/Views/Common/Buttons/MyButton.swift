//
//  MyButton.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI

struct MyButton: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .frame(width: 155, height: 45)
                .background(Color("saveeBlue"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
        }
    }
}

extension View {
    func myButtonStyle() -> some View {
        modifier(MyButton())
    }
}

