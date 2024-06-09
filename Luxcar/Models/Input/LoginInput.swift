//
//  LoginInput.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation

struct LoginInput: Encodable {
    var phoneNumber: String
    var password: String
}

struct ChangePasswordInput: Encodable {
    var oldPassword: String
    var password: String
    var confirmPassword: String
}

struct NewPasswordInput: Encodable {
    var password: String
    var confirmPassword: String
}

struct ForgetPasswordInput: Encodable {
    var phoneNumber: String
    var password: String
    var confirmPassword: String
}

struct UpdateProfileInput: Encodable {
    var fullName: String
    var phoneNumber: String
}

struct AddTokenInput: Encodable {
    var deviceToken: String
    
}


