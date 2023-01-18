//
//  ViewExt.swift
//  Savee
//
//  Created by Nicolas Nguyen on 18.01.2023.
//

import Foundation
import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 5)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35).foregroundColor(Color("lightGray")))
            //.foregroundColor(Color("lightGray"))
            .foregroundColor(.black)
            .padding(10)
    }
}
