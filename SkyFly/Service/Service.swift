//
//  Service.swift
//  Supplies
//
//  Created by Yang Dev Luo on 2021/1/17.
//  Copyright © 2021 Thoughtworks. All rights reserved.
//

import Foundation
import Alamofire

struct SFError: Error, Codable {
    let code:String
    let message:String
    
    static func unkown() -> SFError {
        return SFError(code: "-1", message: "unkown")
    }
}

struct SFResponse<T:Codable>: Codable {
    let error: SFError?
    let data:T?
}

protocol ServiceProrocol {
    func requset<T:Codable>(path: String, method: HTTPMethod, parameters:[String:Any], finished:@escaping (_ responseModel:T?,_ error: SFError?)->())
}

struct Service: ServiceProrocol {
    let host:String
    init(host: String) {
        self.host = host
    }
    
    func requset<T:Codable>(path: String, method: HTTPMethod, parameters:[String:Any], finished:@escaping (_ responseModel:T?,_ error: SFError?)->()) {
        AF.request("\(host)\(path)",method: .post, parameters: parameters).responseDecodable(of: SFResponse<T>?.self) { response in
            debugPrint("Response: \(response)")
            switch response.result {
            case .success(let data):
                finished(data?.data, data?.error)
            case .failure( _):
                let surError = self.mapError(response: response)
                finished(nil, surError)
            }
        }
    }
    
    func mapError<T:Codable>(response:Alamofire.DataResponse<T, AFError>) -> SFError  {
        var message = ""
        switch (response.error!._code){
        case 13:
            message = "服务器无法连接"
            
        default:
            break;
        }
        return SFError(code: "\(response.error!._code)", message: message)
    }
}
