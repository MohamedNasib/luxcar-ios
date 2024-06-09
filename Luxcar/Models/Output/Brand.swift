//
//  Brand.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct Brand: Mappable {
    var _id = ""
    var model: [Model] = []
    var name = ""
    var brandLogo = ""
    var createdAt = ""
    var updatedAt = ""
    var __v = 0
    
    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        model = map.optionalFrom("model") ?? []
        name = map.optionalFrom("name") ?? ""
        brandLogo = map.optionalFrom("brandLogo") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        __v = map.optionalFrom("__v") ?? 0
    }
}
