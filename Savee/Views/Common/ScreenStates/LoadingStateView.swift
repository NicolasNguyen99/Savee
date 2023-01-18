//
//  LoadingStateView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI

struct LoadingStateView: View {
    
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
    }
}
