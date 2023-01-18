//
//  ErrorStateView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 15.01.2023.
//

import SwiftUI

struct ErrorStateView: View {
    
    let error: String
    var retryCallback: (() -> ())? = nil
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text(error)
                if let retryCallback {
                    Button("Retry", action: retryCallback)
                        .buttonStyle(.borderedProminent)
                }
                
            }
            Spacer()
        }
        .padding(64)
    }
}
