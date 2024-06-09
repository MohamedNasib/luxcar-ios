//
//  Model.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct Model: Mappable {
    var _id = ""
    var name = ""
    var brand = ""
    var createdAt = ""
    var updatedAt = ""
    var isSelected = false
    
    init(_id: String, name: String , isSelected: Bool) {
        self._id = _id
        self.name = name
        self.isSelected = isSelected
    }
    
    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        name = map.optionalFrom("name") ?? ""
        brand = map.optionalFrom("brand") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
    }
}
