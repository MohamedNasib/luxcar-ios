//
//  ResourceResponse.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 03/03/2024.
//

import Foundation
import Mapper

struct ResourceResponse: Mappable {
    var dataResult: [ResourceItem]
    var code: Int

    init(map: Mapper) throws {
        dataResult = map.optionalFrom("dataResult") ?? []
        code = map.optionalFrom("code") ?? 0
    }
}

struct ResourceItem: Mappable {
    var _id: String
    var type: String
    var createdAt: String
    var updatedAt: String
    var images: [String]

    init(map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        type = map.optionalFrom("type") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        images = map.optionalFrom("images") ?? []
    }
}

