//
//  Option.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct Option: Mappable {
    var _id = ""
    var code = ""
    var description = ""
    
    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        code = map.optionalFrom("code") ?? ""
        description = map.optionalFrom("description") ?? ""
    }
}
