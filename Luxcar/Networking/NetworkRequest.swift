//
//  NetworkRequest.swift
//  CurePlus
//
//  Created by Ahmed El-elaimy on 14/11/2023.
//

import Moya
import Mapper
import Moya_ModelMapper
import ARSLineProgress
import Toaster

class NetworkRequest {

    func sendRequest(function:apiService, showLoader: Bool = true, success:@escaping(_ code:String, _ msg:String, _ response :Response)->(), failure:@escaping (_ code:String, _ msg:String, _ errors :[String:[String]])->()) {

        ToastCenter.default.cancelAll()
        if showLoader {
            ARSLineProgress.show()
        }
        
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<apiService>(plugins: [plugin])
        
        provider.request(function) { (result) in
            if showLoader {
                ARSLineProgress.hide()
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let Dic = try response.mapJSON() as! [String: Any]
                        let statusCode = response.statusCode
                        switch statusCode {
                        case 0:
                            success("", "", response)
                        case 103:
                            failure("\(statusCode)", "", [:])
                        case 200:
                            success("\(statusCode)", "", response)
                        case 400:
                            failure("\(statusCode)", "", [:])
                        case 401:
                            failure("\(statusCode)", "", [:])
                        case 402:
                            failure("\(statusCode)", "", [:])
                        case 403:
                            failure("\(statusCode)", "", [:])
                        case 404:
                            failure("\(statusCode)", (Dic["message"] as? String) ?? "", [:])
                        case 422:
                            failure("\(statusCode)", "", (Dic["errors"] as! [String : [String]]))
                        case 500:
                            failure("\(statusCode)", "", [:])
                        default:
//                            Toast(text: K_Server_Error).show()
                            print("\(K_Server_Error)")
                        }
                    } catch {
                        print("\(K_Parse_Error)")
//                        Toast(text:K_Parse_Error ).show()
                    }
                case .failure(let error):
                    print("\(error.localizedDescription)")

//                    Toast(text: error.localizedDescription).show()
                }
            }
        }
    }
}
