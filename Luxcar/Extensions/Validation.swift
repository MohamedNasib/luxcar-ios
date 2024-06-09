//
//  Validation.swift
//  CurePlus
//
//  Created by Ahmed El-elaimy on 19/11/2023.
//

import Foundation

extension String {
    
//    func localized() -> String {
//        // Using Mirror to inspect the object
//        if let labels = Archiver.loadLabels() {
//            let mirror = Mirror(reflecting: labels)
//            if let text = mirror.children.first(where: { $0.label == self })?.value as? String {
//                return text.capitalizingFirstLetter()
//            }
//            return NSLocalizedString(self, comment: "")
//        }
//        return NSLocalizedString(self, comment: "")
//    }
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func validateIDNumber() -> (isValid: Bool, errorMessage: String?) {
        let phoneRegex = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        if self.isEmpty {
            return (false, "ID number cannot be empty.")
        } else if !phoneTest.evaluate(with: self) {
            return (false, "ID number must contain exactly 10 digits.")
        } else {
            return (true, nil)
        }
    } 
    
    func validateName() -> (isValid: Bool, errorMessage: String?) {
        if self.isEmpty {
            return (false, "full name field is required.")
        } else {
            return (true, nil)
        }
    }

    // Phone number validation
    func validatePhoneNumber() -> (isValid: Bool, errorMessage: String?) {
        let phoneRegex = "^[0-9]{9,}$"  // Regex pattern for 9 or more digits
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        
        if self.isEmpty {
            return (false, "Phone number cannot be empty.")
        } else if !phoneTest.evaluate(with: self) {
            return (false, "Phone number must contain only digits and be at least 9 digits long.")
        } else {
            return (true, nil)
        }
    }


    // Password validation
    func validatePassword(minLength: Int = 6) -> (isValid: Bool, errorMessage: String?) {
        if self.isEmpty {
            return (false, "Password cannot be empty.")
        } else if self.count < minLength {
            return (false, "Password must be at least \(minLength) characters long.")
        }
        // Add more rules if necessary
        return (true, nil)
    }
    
    // confirm Password validation
    func validateConfirmPassword(minLength: Int = 6 , password: String) -> (isValid: Bool, errorMessage: String?) {
        if self.isEmpty {
            return (false, "Confirm Password cannot be empty.")
        } else if self.count < minLength {
            return (false, "Confirm Password must be at least \(minLength) characters long.")
        }
        else if self != password {
            return (false, "Unidentical password.")
        }
        // Add more rules if necessary
        return (true, nil)
    }
}
