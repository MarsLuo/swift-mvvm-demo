//
//  SelectSeatViewModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation
import UIKit

enum SelectCellType {
    case empty
    case number
    case seatType
    case seat
}

protocol SelectSeatProtocol {
    
    func cellType(_ indexPath: IndexPath) -> SelectCellType
    func cellImage(_ status: SeatStatus) -> UIImage?
    func typeString(_ row: Int) -> String
    func rowNumber(_ section: Int) -> String
    
}

class SelectSeatViewModel: SelectSeatProtocol {
    
    static let types = ["P", "A", "B", "C", "", "H", "J", "K", "P"]
    
    static let flySeatNumber = 32
    
    func cellType(_ indexPath: IndexPath) -> SelectCellType {
        
        if indexPath.row == 4 {
            return .empty
        }
        
        if indexPath.section == 0 {
            return .seatType
        }
        
        if indexPath.row == 0 || indexPath.row == 8 {
            return .number
        }
        return .seat
    }
    
    func cellImage(_ status: SeatStatus) -> UIImage? {
        switch status {
        case .selectabel:
            return UIImage(named: "select_seat")
        case .selected:
            return UIImage(named: "selected_seat")
        case .yourSelect:
            return UIImage(named: "my_seat")
        }
    }
    
    func typeString(_ row: Int) -> String {
        return SelectSeatViewModel.types[row]
    }
    
    func rowNumber(_ section: Int) -> String {
        return "\(SelectSeatViewModel.flySeatNumber - section)"
    }
}
