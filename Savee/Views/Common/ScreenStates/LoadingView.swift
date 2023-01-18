//
//  LoadingView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 18.01.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color("lightGray")
                .opacity(0.4)
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Loading")
                }
                Spacer()
            }
        }
    }
}
