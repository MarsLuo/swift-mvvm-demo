//
//  StubService.swift
//  SuppliesTests
//
//  Created by Yang Dev Luo on 2021/1/17.
//  Copyright © 2021 Thoughtworks. All rights reserved.
//

import Foundation
@testable import SkyFly
import Alamofire

struct StubService: ServiceProrocol {
 
    var error: SFError?
    var data: Any?
    init(error: SFError?, data: Any?) {
        self.error = error
        self.data = data
    }
    
    func requset<T>(path: String, method: HTTPMethod, parameters: [String : Any], finished: @escaping (T?, SFError?) -> ()) where T : Decodable, T : Encodable {
        if let error = error {
            finished(nil, error)
        } else if let data = data{
            finished(data as! T, error)
        }
    }
}
