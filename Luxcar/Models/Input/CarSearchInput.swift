//
//  Brand.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation

struct CarSearchInput: Encodable{
    var pageNumber: String
    var numberOfItems: String
    var name: String
    var carStatus: String
    var carImport: String
    var description: String
}
