//
//  AuthView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift

class UserAuthenticated: ObservableObject {
    @Published var isAuthenticated = false
}

struct AuthView: View {
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        NavigationView {
            if let user = self.app.currentUser {
                let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
                    print("\(subs.count)")
                    if let foundSubscription = subs.first(named: "transactions") {
                        foundSubscription.updateQuery(toType: Transaction.self, where: {
                            $0.ownerId == user.id
                        })
                    } else {
                        subs.append(QuerySubscription<Transaction>(name: "transactions") {
                            $0.ownerId == user.id
                        })
                    }
                    
                    if let foundSubscription = subs.first(named: "categories") {
                        foundSubscription.updateQuery(toType: Category.self, where: {
                            $0.ownerId == user.id
                        })
                    } else {
                        subs.append(QuerySubscription<Category>(name: "categories") {
                            $0.ownerId == user.id
                        })
                    }
                }, rerunOnOpen: true)
                RealmView()
                    .environment(\.realmConfiguration, config)
            } else {
                VStack {
                    Text("Let's get started!")
                        .caption1TextStyle()
                    
                    Image("auth_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 300)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    VStack {
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Log in button")
                                .myButtonStyle()
                        }.buttonStyle(.plain)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Sign up button")
                                .myButtonStyle()
                        }.buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}
