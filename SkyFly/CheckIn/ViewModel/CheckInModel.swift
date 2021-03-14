//
//  CheckInModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation

enum SeatStatus : Int, Codable {
    case selectabel = 0
    case selected = 1
    case yourSelect = 2
}

struct CheckInSeat: Codable {
    let id : String
    let row : Int
    let section : Int
    let status: SeatStatus
    
    func para() -> [String:Any] {
        return ["id":id, "row": row, "section": section]
    }
}
