//
//  CategoryTabView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 13.01.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        HStack(spacing: 15) {
            Picker("", selection: $currentTab) {
                Text("Expenses").tag(0)
                Text("Income").tag(1)
                Text("Investments").tag(2)
            }
            .pickerStyle(.segmented)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
            }
        }
    }
}
