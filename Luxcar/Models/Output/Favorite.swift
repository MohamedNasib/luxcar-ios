//
//  Favorite.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import Foundation
import Mapper

struct Favorite: Mappable {
    var _id = ""
    var car = ""
    var user = ""
    var createdAt = ""
    var updatedAt = ""

    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        car = map.optionalFrom("car") ?? ""
        user = map.optionalFrom("user") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
    }
}
