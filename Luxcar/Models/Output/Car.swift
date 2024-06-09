//
//  Car.swift
//  Luxcar
//
//  Created by mac on 07/01/2024.
//

import Foundation
import Mapper

struct CarResponse: Mappable {
    let message: String
    let cars: [Car]
    let numberOfPages: Int
    let totalNumberOfItems: Int
    let code: Int

    init(map: Mapper) throws {
        message = map.optionalFrom("message") ?? ""
        cars = map.optionalFrom("dataResultWithFavorites") ?? []
        numberOfPages = map.optionalFrom("numberOfPages") ?? 0
        totalNumberOfItems = map.optionalFrom("totalNumberofItems") ?? 0
        code = map.optionalFrom("code") ?? 0
    }
}

struct Car: Mappable {
    let id: String
    let images: [String]
    let name: String
    let year: String
    let description: String
    let offerNumber: String
    let mileAge: String
    let currency: String
    let isFinancialPossibleThroughBankPartners: Bool
    let isWorldwideExportPossible: Bool
    let status: String
    let carImport: String
    let carStatus: String
    let grossPrice: Double
    let netExportPrice: Double
    let model: CarModel?
    let options: [Option]
    let attributes: [Attribute]
    let brand: CarBrand?
    let isFavorite: Bool

    init(map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        images = map.optionalFrom("images") ?? []
        name = map.optionalFrom("name") ?? ""
        year = map.optionalFrom("year") ?? ""
        description = map.optionalFrom("description") ?? ""
        offerNumber = map.optionalFrom("offerNumber") ?? ""
        mileAge = map.optionalFrom("mileAge") ?? ""
        currency = map.optionalFrom("currency") ?? ""
        isFinancialPossibleThroughBankPartners = map.optionalFrom("isFinancialPossibleThroughBankPartners") ?? false
        isWorldwideExportPossible = map.optionalFrom("isWorldwideExportPossible") ?? false
        status = map.optionalFrom("status") ?? ""
        carImport = map.optionalFrom("carImport") ?? ""
        carStatus = map.optionalFrom("carStatus") ?? ""
        grossPrice = map.optionalFrom("grossPrice") ?? 0.0
        netExportPrice = map.optionalFrom("netExportPrice") ?? 0.0
        model = map.optionalFrom("model")
        options = map.optionalFrom("options") ?? []
        attributes = map.optionalFrom("attributes") ?? []
        brand = map.optionalFrom("brand")
        isFavorite = map.optionalFrom("isFavorite") ?? false
    }
}

struct CarModel: Mappable {
    let id: String
    let name: String
    let brandId: String
    let createdAt: String?
    let updatedAt: String?

    init(map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        name = map.optionalFrom("name") ?? ""
        brandId = map.optionalFrom("brand") ?? ""
        createdAt = map.optionalFrom("createdAt")
        updatedAt = map.optionalFrom("updatedAt")
    }
}

struct CarBrand: Mappable {
    let id: String
    let name: String
    let brandLogo: String
    let createdAt: String?
    let updatedAt: String?

    init(map: Mapper) throws {
        id = map.optionalFrom("_id") ?? ""
        name = map.optionalFrom("name") ?? ""
        brandLogo = map.optionalFrom("brandLogo") ?? ""
        createdAt = map.optionalFrom("createdAt")
        updatedAt = map.optionalFrom("updatedAt")
    }
}
