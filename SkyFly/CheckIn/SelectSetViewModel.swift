//
//  SelectSetViewModel.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation
import UIKit

enum SelectCellType {
    case empty
    case number
    case setType
    case set
}

protocol SelectSetProtocol {
    
    func cellType(_ indexPath: IndexPath) -> SelectCellType
    func cellImage(_ status: SetStatus) -> UIImage?
    func typeString(_ row: Int) -> String
    func rowNumber(_ section: Int) -> String
    
}

class SelectSetViewModel: SelectSetProtocol {
    
    static let types = ["P", "A", "B", "C", "", "H", "J", "K", "P"]
    
    static let flySetNumber = 32
    
    func cellType(_ indexPath: IndexPath) -> SelectCellType {
        
        if indexPath.row == 4 {
            return .empty
        }
        
        if indexPath.section == 0 {
            return .setType
        }
        
        if indexPath.row == 0 || indexPath.row == 8 {
            return .number
        }
        return .set
    }
    
    func cellImage(_ status: SetStatus) -> UIImage? {
        switch status {
        case .selectabel:
            return UIImage(named: "select_set")
        case .selected:
            return UIImage(named: "selected_set")
        case .yourSelect:
            return UIImage(named: "my_set")
        }
    }
    
    func typeString(_ row: Int) -> String {
        return SelectSetViewModel.types[row]
    }
    
    func rowNumber(_ section: Int) -> String {
        return "\(SelectSetViewModel.flySetNumber - section)"
    }
}
