//
//  CancelBookingInput.swift
//  CurePlus
//
//  Created by Ahmed El-elaimy on 15/11/2023.
//

import Foundation

struct RegisterInput: Encodable {
    var fullName: String
    var phoneNumber: String
    var password: String
    var confirmPassword: String
}

struct VerifyPnoneInput: Encodable {
    var phoneNumber: String
    var isVerified: Bool
}
