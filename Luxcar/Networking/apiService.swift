//
//  apiService.swift
//  CurePlus
//
//  Created by Ahmed El-elaimy on 14/11/2023.
//

import Moya
import SwiftUI

enum apiService {
    // auth
    case register(params: RegisterInput)
    case verifyPhone(params: VerifyPnoneInput)
    case login(params: LoginInput)
    case changePassword(params: ChangePasswordInput)
    case forgetPassword(params: ForgetPasswordInput)
    case addDeviceToken(params: AddTokenInput)
    case logout(params: AddTokenInput)
    //brand
    case brandList(params: GetBrandListInput)
    case getBrand(id: String)
    //Car
    case carList(params: GetCarListInput)
    case getCar(id: String)
    case getCarLatest
    case getCarModel(id: String , params: GetModelListInput)
    case getCarBrand(id: String , params: GetBrandListInput)
    case carSearch(params: CarSearchInput)
    //model
    case modelList(params: GetBrandListInput)
    case getmodel(id: String)
    //favorite
    case addCarTofavorite(carId: String)
    case deleteCarFromfavorite(carId: String)
    case favouriteList(params: GetFavoriteListInput)
    case getCarFromfavorite(carId: String)
    // order
    case getOrder(carId: String , params: GetOrderInput)
    // user profile
    case getProfile
    case updateProfile(params: UpdateProfileInput)
    
    case staticData

}

// MARK: - TargetType Protocol Implementation
extension apiService: TargetType {
    var baseURL: URL { return URL(string: BaseUrl)! }
    
    var path: String {
        switch self {
        case .register:
            return "auth/register"
        case .verifyPhone:
            return "auth/verify-phonenumber"
        case .login:
            return "auth/login"
        case .changePassword:
            return "auth/change-password"
        case .forgetPassword:
            return "auth/forget-password"
        case .addDeviceToken:
            return "auth/add-device-token"
        case .logout:
            return "auth/logout"
        case .brandList:
            return "brand/list"
        case .getBrand(let id):
            return "brand/\(id)"
        case .carList:
            return "car/list"
        case .getCar(let id):
            return "car/\(id)"
        case .getCarLatest:
            return "car/latest"
        case .getCarModel(let id, _):
            return "car/model/\(id)"
        case .getCarBrand(let id, _):
            return "car/brand/\(id)"
        case .carSearch:
            return "car/search"
        case .modelList:
            return "model/list"
        case .getmodel(let id):
            return "model/\(id)"
        case .addCarTofavorite(let carId):
            return "favorites/add/\(carId)"
        case .deleteCarFromfavorite(let carId):
            return "favorites/delete/\(carId)"
        case .favouriteList:
            return "favorites/list"
        case .getCarFromfavorite(let carId):
            return "favorites/\(carId)"
        case .getOrder(let carId , _):
            return "order/place-order/\(carId)"
        case .getProfile:
            return "user/profile"
        case .updateProfile:
            return "user/profile/update"
        case .staticData:
            return "static-data/get/mobile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register , .verifyPhone , .login , .addDeviceToken , .logout , .addCarTofavorite , .getOrder:
            return .post
        case .changePassword , .forgetPassword , .updateProfile:
            return .patch
            
        case .deleteCarFromfavorite:
            return .delete
                        
        default:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        switch self {
        case .register(let params):
            parameters = params.toDictionary ?? [:]
        case .verifyPhone(let params):
            parameters = params.toDictionary ?? [:]
        case .login(let params):
            parameters = params.toDictionary ?? [:]
        case .addDeviceToken(let params):
            parameters = params.toDictionary ?? [:]
        case .logout(let params):
            parameters = params.toDictionary ?? [:]
        case .changePassword(let params):
            parameters = params.toDictionary ?? [:]
        case .forgetPassword(let params):
            parameters = params.toDictionary ?? [:]
        case .brandList(let params):
            parameters = params.toDictionary ?? [:]
        case .getBrand(let params):
            parameters = params.toDictionary ?? [:]
//        case .carList(let params):
//            parameters = params.toDictionary ?? [:]
        case .getCar(let params):
            parameters = params.toDictionary ?? [:]
        case .getCarModel(let params , _):
            parameters = params.toDictionary ?? [:]
        case .getCarBrand(let params , _):
            parameters = params.toDictionary ?? [:]
        case .carSearch(let params):
            parameters = params.toDictionary ?? [:]
        case .modelList(let params):
            parameters = params.toDictionary ?? [:]
        case .getmodel(let params):
            parameters = params.toDictionary ?? [:]
        case .addCarTofavorite(let params):
            parameters = params.toDictionary ?? [:]
        case .deleteCarFromfavorite(let params):
            parameters = params.toDictionary ?? [:]
        case .favouriteList(let params):
            parameters = params.toDictionary ?? [:]
        case .getCarFromfavorite(let params):
            parameters = params.toDictionary ?? [:]
        case .getOrder(_ ,let params):
            parameters = params.toDictionary ?? [:]
        case .updateProfile(let params):
            parameters = params.toDictionary ?? [:]
       
        default:
            parameters = [String: Any]()
        }
        return parameters
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
            
        case .register , .verifyPhone , .login , .changePassword , .forgetPassword , .getOrder , .updateProfile, .addDeviceToken, .logout:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
            
        default:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.queryString)

        }
    }
    
    var headers: [String: String]? {
        print("Bearer: \(K_Defaults.string(forKey: Saved.TOKEN) ?? "")")
        var parameters = [String: String]()
        if !"\(K_Defaults.string(forKey: Saved.TOKEN) ?? "")".isEmpty {
            parameters["Authorization"] = "Bearer \(K_Defaults.string(forKey: Saved.TOKEN) ?? "")"
        }
        parameters["accept"] = "application/json"
        parameters["Content-Type"] = "application/json"
        return parameters
    }
    
    var sampleData: Data {
        return Data()
    }
    
}
