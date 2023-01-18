//
//  RealmView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift

struct RealmView: View {
    @ObservedResults(Category.self) var categories
    @AutoOpen(appId: "savee-jhezu") var realmOpen
    @StateObject var appVM = AppViewModel()
    
    var body: some View {
        switch realmOpen {
        case .connecting:
            ProgressView("Connecting")
        case .waitingForUser:
            ProgressView("Waiting for user..")
        case .open(let realm):
            MainDashboardView()
                .environment(\.realm, realm)
                .environmentObject(appVM)
                .task {
                    if categories.count == 0 {
                        try? realm.write {
                            realm.add(fixedCategories)
                        }
                    }
                }
        case .progress(let progress):
            ProgressView(progress)
        case .error(let error):
            Text("Sorry, opening realm error \(error.localizedDescription)")
                .foregroundColor(.red)
        }
    }
}
