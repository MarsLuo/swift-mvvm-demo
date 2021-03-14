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

protocol NetWorkClientProtocol {
    func request<T:Decodable>(path:String,
                      method: HTTPMethod,
                      parameters: Parameters?,
                      decodeType: T.Type,
                      completionHandler: @escaping (AFDataResponse<T>) -> Void)
}

struct AFNetWorkImp: NetWorkClientProtocol {
    func request<T>(path: String, method: HTTPMethod, parameters: Parameters?, decodeType: T.Type, completionHandler: @escaping (AFDataResponse<T>) -> Void) where T : Decodable {
        AF.request(path, method: .post, parameters: parameters).responseDecodable(of: T.self, completionHandler: completionHandler)
    }
}

protocol ServiceProtocol {
    func requset<T:Codable>(path: String, method: HTTPMethod, parameters:[String:Any], finished:@escaping (_ responseModel:T?,_ error: SFError?)->())
    func chekcInSeat<T:Codable>(passageId:String, body:[String:Any], finished:@escaping (_ responseModel:T?,_ error: SFError?)->())
}

struct Service: ServiceProtocol {
    let host:String
    let client:NetWorkClientProtocol
    init(host: String, client:NetWorkClientProtocol) {
        self.host = host
        self.client = client
    }
    
    func requset<T:Codable>(path: String, method: HTTPMethod, parameters:[String:Any], finished:@escaping (_ responseModel:T?,_ error: SFError?)->()) {
        
        client.request(path: "\(host)\(path)", method: .post, parameters: parameters, decodeType: SFResponse<T>?.self) { (response) in
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
        switch (response.error){
        case .sessionTaskFailed:
            message = "服务器无法连接"
            
        default:
            message = "unkown"
            break;
        }
        return SFError(code: "\(response.error!._code)", message: message)
    }
}

