//
//  CheckInViewModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation
import Alamofire

protocol CheckInProtocol {
    
}

class CheckInViewModel: CheckInProtocol {
    
    static let passagerId = "1"
    let service: ServiceProrocol
    
    init (service: ServiceProrocol) {
        self.service = service
    }
    
    func bookSet(set:CheckInSet, success:@escaping (CheckInSet) -> Void, failure:@escaping (SFError) -> Void) {
        service.requset(path: "/api/v1/mobile/passenger/\(CheckInViewModel.passagerId)/checkin", method: .post, parameters: set.para()) { (data: CheckInSet?, error) in
            if let data = data {
                success(data)
            } else {
                failure(error ?? SFError.unkown())
            }
        }
    }
}
