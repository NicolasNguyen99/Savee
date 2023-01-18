//
//  IconCircle.swift
//  Savee
//
//  Created by Nicolas Nguyen on 13.01.2023.
//

import SwiftUI

struct IconCircle: View {
    var backgroundColor: Color
    var iconName: String = "questionmark.folder.fill"
    var imageSize: Int = 35
    var circleSize: Int = 45
    
    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .frame(width: CGFloat(circleSize), height: CGFloat(circleSize))
            Image(systemName: iconName)
                .frame(width: CGFloat(imageSize), height: CGFloat(imageSize))
                .foregroundColor(.white)
        }
    }
}
