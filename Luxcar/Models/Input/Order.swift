//
//  Order.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation

struct GetOrderInput: Encodable{
    var fullName: String
    var phoneNumber: String
    var orderType: String
}
