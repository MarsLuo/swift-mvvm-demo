//
//  CheckInViewModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation
import Alamofire

protocol CheckInProtocol {
    func bookSeat(index:IndexPath, success:@escaping (CheckInSeat) -> Void, failure:@escaping (String) -> Void, retry:@escaping (String) -> Void)
    func getSeatStatus(row:Int, section:Int) -> SeatStatus
    var retryIndex: IndexPath? { get set }
    func retryTitle(row:Int, section:Int) -> String
}

class CheckInViewModel: CheckInProtocol {
    
    static let demoIndex = IndexPath.init(row: 3, section: 3)
    static let passagerId = "1"
    static let changeSeatCode = "100001"
    
    let service: ServiceProtocol
    var yourSeat: CheckInSeat?
    var retryIndex: IndexPath?
    
    init (service: ServiceProtocol) {
        self.service = service
        self.yourSeat = nil
        self.retryIndex = nil
    }
    
    func retryTitle(row: Int, section: Int) -> String {
        return "您选的是：\(SeatTools.rowNumber(section))\(SeatTools.typeString(row))，点此重试"
    }
    
    func bookSeat(index:IndexPath, success:@escaping (CheckInSeat) -> Void, failure:@escaping (String) -> Void, retry:@escaping (String) -> Void) {
        let seat = CheckInSeat(id: CheckInViewModel.passagerId, row: index.row, section: index.section, status: .yourSelect)
        service.chekcInSeat(passageId: CheckInViewModel.passagerId, body: seat.para()) { (data: CheckInSeat?, error) in
            if let checkInSeat = data {
                self.yourSeat = checkInSeat
                success(checkInSeat)
            } else if let skErrpr = error, skErrpr.code == CheckInViewModel.changeSeatCode {
                failure(skErrpr.message)
            } else {
                self.retryIndex = index
                retry("当前服务不可用，请点击重试按钮重试")
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
