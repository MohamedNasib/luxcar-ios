//
//  Brand.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation

struct GetBrandListInput: Encodable{
    var pageNumber: String
    var numberOfItems: String
}
struct GetModelListInput: Encodable{
    var pageNumber: String
    var numberOfItems: String
}
struct GetFavoriteListInput: Encodable{
    var pageNumber: String
    var numberOfItems: String
}
struct GetCarListInput: Encodable{
    var pageNumber: String
    var numberOfItems: String
}
