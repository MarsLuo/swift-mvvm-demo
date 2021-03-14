//
//  ServiceSpec.swift
//  SkyFlyTests
//
//  Created by Yang Dev Luo on 2021/3/13.
//
import Foundation
import Quick
import Nimble
import Alamofire

@testable import SkyFly

struct TestStruct : Codable {
    let name: String
    let label: String
}

struct TestError :Error {
}

struct StubNetWorkClient: NetWorkClientProtocol {
    let success:Bool
    
    
    func request<T>(host: String, method: HTTPMethod, parameters: Parameters?, decodeType: T.Type, completionHandler: @escaping (AFDataResponse<T>) -> Void) where T : Decodable {
        
        if !success {
            let result: Result<T, AFError> = .failure(.explicitlyCancelled)
            let response = AFDataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1.0, result: result)
            completionHandler(response)
        }
    }
}


class ServiceSpec: QuickSpec {
    override func spec() {
        describe("test Service") {
            it("request failure ") {
                
                let service = Service(host: "", client: StubNetWorkClient(success: false))

                waitUntil { done in
                    service.requset(path: "", method: .get, parameters: [:]) { (data:TestStruct?, error) in
                        if error != nil {
                            done()
                        }
                    }
                }
            }
            
            it("mapError sessionTaskFailed") {
                let service = Service(host: "", client: StubNetWorkClient(success: false))
                
                let result: Result<TestStruct, AFError> = .failure(.sessionTaskFailed(error: TestError()))
                let response = AFDataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1.0, result: result)
                
                let error = service.mapError(response: response)
                expect(error.message).to(equal("服务器无法连接"))
            }
            
            it("mapError unkown") {
                let service = Service(host: "", client: StubNetWorkClient(success: false))
                
                let result: Result<TestStruct, AFError> = .failure(.sessionDeinitialized)
                let response = AFDataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1.0, result: result)
                
                let error = service.mapError(response: response)
                expect(error.message).to(equal("unkown"))
            }
        }
    }
}
