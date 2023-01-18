//
//  SettingsView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI
import RealmSwift

struct MoreView: View {
    @ObservedObject var authManager = AuthManager()
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var shouldShowAlert = false
    
    @ObservedResults(Category.self) var categories
    
    var body: some View {
        NavigationView {
            settingsListView
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("more")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("log out")
                            .foregroundColor(Color("saveeBlue"))
                            .onTapGesture {
                                shouldShowAlert = true
                            }
                    }
                }
                .alert("Do you want to log out?", isPresented: $shouldShowAlert) {
                    Button("log out", role: .destructive) {
                        authManager.logout()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("cancel", role: .cancel) { }
                }
        }
    }
    
    private var settingsListView: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 40))
                Text("\(app.currentUser?.profile.email ?? "")")
                    .font(.system(size: 24))
                    .foregroundColor(Color("saveeBlue"))
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            
            List {
                Section("profile") {
                    NavigationLink {
                        CategoriesView()
                    } label: {
                        HStack {
                            Image(systemName: "square.grid.2x2")
                            Text("categories")
                            
                            Spacer()
                            
                            Text("\(categories.count)")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "globe")
                        Text("language")
                        
                        Spacer()
                    }
                    .onTapGesture {}
                    
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("currency")
                        
                        Spacer()
                    }
                    .onTapGesture {}
                }
            }
            .listStyle(.plain)
        }
    }
}
