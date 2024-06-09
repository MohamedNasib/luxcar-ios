//
//  DataResult.swift
//  Luxcar
//
//  Created by mac on 08/01/2024.
//

import Foundation
import Mapper

struct DataResult: Mappable {
    var message = ""
    var numberOfPages = 0
    var totalNumberofItems = 0
    var code = 0

    init(map: Mapper) throws {
        message = map.optionalFrom("message") ?? ""
        numberOfPages = map.optionalFrom("numberOfPages") ?? 0
        totalNumberofItems = map.optionalFrom("totalNumberofItems") ?? 0
        code = map.optionalFrom("code") ?? 0
    }
}
