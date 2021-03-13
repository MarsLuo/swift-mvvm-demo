//
//  CheckInModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation

enum SetStatus : Int, Codable {
    case selectabel = 0
    case selected = 1
    case yourSelect = 2
}

struct CheckInSet: Codable {
    let id : String
    let row : Int
    let section : Int
    let status: SetStatus
    
    func para() -> [String:Any] {
        return ["row": row, "section": section]
    }
}
