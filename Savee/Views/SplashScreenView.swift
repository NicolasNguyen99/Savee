//
//  SplashScreenView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift

var _app: RealmSwift.App? = nil

var app: RealmSwift.App {
    if (_app == nil) {
        setenv("REALM_DISABLE_METADATA_ENCRYPTION", "YES", 1)
        _app = RealmSwift.App(id: "savee-jhezu")
    }
    return _app!
}

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            AuthView(app: app)
                .environment(\.realmConfiguration, RealmMigrator.configuration)
        } else {
            VStack {
                VStack {
                    Image("wallet")
                        .resizable()
                        .frame(width: 160, height: 160)
                    Text("Savee")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black.opacity(0.8))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
