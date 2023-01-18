//
//  ValidationManager.swift
//  Savee
//
//  Created by Nicolas Nguyen on 05.01.2023.
//

import Foundation

final class ValidationManager {
    func validateEmail(input: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: input)
    }
}
