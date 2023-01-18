//
//  SaveeApp.swift
//  Savee
//
//  Created by Nicolas Nguyen on 29.12.2022.
//

import SwiftUI
import RealmSwift

@main
struct SaveeApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            SplashScreenView()
        }
    }
}
