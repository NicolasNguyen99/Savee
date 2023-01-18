//
//  SignUpView.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var authManager = AuthManager()
    
    var body: some View {
        VStack {
            Image("wallet")
                .resizable()
                .frame(width: 160, height: 160)
            
            Spacer()
                .frame(height: 50)
            
            Text("Sign up")
                .header1TextStyle()
            
            VStack {
                TextField("Email", text: $authManager.email)
                    .underlineTextField()
                SecureField("Password", text: $authManager.password)
                    .underlineTextField()
                SecureField("Re-type password", text: $authManager.passwordRepeat)
                    .underlineTextField()
                Text(authManager.error)
                    .foregroundColor(.red)
                    .opacity(authManager.error != "" ? 1 : 0)
            }
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            
            Spacer()
                .frame(height: 20)
            
            Button {
                authManager.registration()
            } label: {
                Text("Sign up")
                    .myButtonStyle()
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            NavigationLink {
                LoginView()
            } label: {
                HStack {
                    Text("Allready have an account?")
                        .foregroundColor(.black)
                    Text("Log in button")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
