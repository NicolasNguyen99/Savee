//
//  AuthManager.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import Foundation
import Combine
import RealmSwift

class AuthManager: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordRepeat: String = ""
    
    @Published var buttonDisabled: Bool = true
    @Published var arePasswordSame: Bool = true
    
    @Published var isLoading: Bool = false
    @Published var error: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private var validationManager = ValidationManager()
    
    init() {
        bindValidationManager()
    }
    
    func login() {
        isLoading = true
        let credentials = Credentials.emailPassword(email: email, password: password)
        app.login(credentials: credentials) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Logged in as: \(user.id)")
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("error: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
        }
    }
    
    func registration() {
        isLoading = true
        app.emailPasswordAuth.registerUser(email: email, password: password) { [weak self](error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Signup failed: \(error!)")
                    self?.error = "Signup failed: \(error!.localizedDescription)"
                    self?.isLoading = false
                    return
                }
                print("Signup successful!")
                self?.login()
            }
        }
    }
    
    
    func logout() {
        app.currentUser?.logOut() { error in
            if let error = error {
                print("Error during logout: \(error.localizedDescription)")
            }
        }
    }
}

private extension AuthManager {
    func bindValidationManager() {
        $email
            .map { email in
                let correctEmail = self.validationManager.validateEmail(input: email)
                return !correctEmail
            }
            .assign(to: \.buttonDisabled, on: self)
            .store(in: &cancellables)
        
        $password
            .map { password in
                return password == self.passwordRepeat
            }
            .assign(to: \.arePasswordSame, on: self)
            .store(in: &cancellables)
        
        $passwordRepeat
            .map { passwordRepeat in
                return passwordRepeat == self.password
            }
            .assign(to: \.arePasswordSame, on: self)
            .store(in: &cancellables)
    }
}
