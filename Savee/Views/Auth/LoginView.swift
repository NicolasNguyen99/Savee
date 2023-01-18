//
//  LoginView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authManager = AuthManager()
    
    var body: some View {
        VStack {
            Image("wallet")
                .resizable()
                .frame(width: 160, height: 160)
            
            Spacer()
                .frame(height: 50)
            
            Text("Log in")
                .header1TextStyle()
            
            VStack {
                TextField("Email", text: $authManager.email)
                    .underlineTextField()
                
                SecureField("Password", text: $authManager.password)
                    .underlineTextField()
                
                Text(authManager.error)
                    .foregroundColor(.red)
                    .opacity(authManager.error != "" ? 1 : 0)
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            Spacer()
                .frame(height: 20)
            
            Button {
                authManager.login()
            } label: {
                Text("Log in button")
                    .myButtonStyle()
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            NavigationLink {
                SignUpView()
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.black)
                    Text("Sign up")
                        .foregroundColor(Color("saveeBlue"))
                        .bold()
                }
            }
        }
        .overlay {
            if authManager.isLoading {
                LoadingView()
            }
        }
    }
}
