//
//  User.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct User: Mappable {
    var message = ""
    var token = ""

    init(map: Mapper) throws {
        message = map.optionalFrom("message") ?? ""
        token = map.optionalFrom("token") ?? ""
    }
}

struct UserProfileResponse: Mappable {
    let message: String
    let userProfile: UserProfile

    init(map: Mapper) throws {
        message = map.optionalFrom("message") ?? ""
        userProfile = try map.from("dataResult")
    }
}

struct UserProfile: Mappable {
    let isVerified: Bool
    let deviceTokens: [String]
    let orders: [Order] // Assuming an Order model exists or could be an empty array if not needed
    let id: String
    let fullName: String
    let password: String
    let phoneNumber: String
    let createdAt: String?
    let updatedAt: String?

    init(map: Mapper) throws {
        isVerified = map.optionalFrom("isVerified") ?? false
        deviceTokens = map.optionalFrom("deviceTokens") ?? []
        orders = map.optionalFrom("orders") ?? []
        id = map.optionalFrom("_id") ?? ""
        fullName = map.optionalFrom("fullName") ?? ""
        password = map.optionalFrom("password") ?? ""
        phoneNumber = map.optionalFrom("phoneNumber") ?? ""
        createdAt = map.optionalFrom("createdAt")
        updatedAt = map.optionalFrom("updatedAt")
    }
}

// Assuming an Order model exists, it might look something like this:
struct Order: Mappable {
    // Define the properties of an Order based on your JSON structure for orders
    // For example:
    let id: String
    let status: String
    let amount: Double

    init(map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        status = map.optionalFrom("status") ?? ""
        amount = map.optionalFrom("amount") ?? 0.0
    }
}
