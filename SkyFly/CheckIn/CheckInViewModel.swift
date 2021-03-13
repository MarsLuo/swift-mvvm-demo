//
//  CheckInViewModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation
import Alamofire

protocol CheckInProtocol {
    func bookSeat(index:IndexPath, success:@escaping (CheckInSeat) -> Void, failure:@escaping (SFError) -> Void)
    func getSeatStatus(row:Int, section:Int) -> SeatStatus
}

class CheckInViewModel: CheckInProtocol {
    
    static let demoIndex = IndexPath.init(row: 3, section: 3)
    static let passagerId = "1"
    let service: ServiceProrocol
    var yourSeat: CheckInSeat?
    
    init (service: ServiceProrocol) {
        self.service = service
        self.yourSeat = nil
    }
    
    func bookSeat(index:IndexPath, success:@escaping (CheckInSeat) -> Void, failure:@escaping (SFError) -> Void) {
        let seat = CheckInSeat(id: CheckInViewModel.passagerId, row: index.row, section: index.section, status: .yourSelect)
        service.requset(path: "/api/v1/mobile/passenger/\(CheckInViewModel.passagerId)/checkin", method: .post, parameters: seat.para()) { (data: CheckInSeat?, error) in
            if let checkInSeat = data {
                self.yourSeat = checkInSeat
                success(checkInSeat)
            } else {
                failure(error ?? SFError.unkown())
            }
        }
    }
    
    func getSeatStatus(row:Int, section:Int) -> SeatStatus {
        
        if let selectedSeat = yourSeat, row == selectedSeat.row, section == selectedSeat.section {
            return .yourSelect
        }
        
        if row == CheckInViewModel.demoIndex.row, section == CheckInViewModel.demoIndex.section {
            return .selectabel
        }
        
        return Bool.random() ? .selectabel :.selected
    }
}
