//
//  MyButtonWide.swift
//  Savee
//
//  Created by Nicolas Nguyen on 06.01.2023.
//

import SwiftUI

struct MyButtonWide: ViewModifier {
    func body(content: Content) -> some View {
        HStack() {
            content
                .frame(width: 320, height: 45)
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
    func myWideButtonStyle() -> some View {
        modifier(MyButtonWide())
    }
}
