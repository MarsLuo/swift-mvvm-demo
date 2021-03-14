//
//  SelectSeatCell.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit

class SelectSeatCell: UICollectionViewCell {
    
    @IBOutlet weak var content: UIButton!
    
    func configCell(_ indexPath: IndexPath, status: SeatStatus) {
        switch SeatTools.cellType(indexPath) {
        case .empty:
            content.setTitle("", for: .normal)
            content.setImage(nil, for: .normal)
        case .number:
            content.setTitle(SeatTools.rowNumber(indexPath.section), for: .normal)
            content.setImage(nil, for: .normal)
        case .seatType:
            content.setTitle(SeatTools.typeString(indexPath.row), for: .normal)
            content.setImage(nil, for: .normal)
        case .seat:
            content.setTitle("", for: .normal)
            content.setImage(SeatTools.cellImage(status), for: .normal)
        }
    }
}
