//
//  Attribute.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct Attribute: Mappable {
    var isVisible = false
    var _id = ""
    var key = ""
    var value = ""
    
    init(key: String = "", value: String = "") {
        self.key = key
        self.value = value
    }
    
    init(map: Mapper) throws {
        isVisible = map.optionalFrom("isVisible") ?? false
        _id = map.optionalFrom("_id") ?? ""
        key = map.optionalFrom("key") ?? ""
        value = map.optionalFrom("value") ?? ""
    }
}
