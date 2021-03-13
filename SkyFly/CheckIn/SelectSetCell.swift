//
//  SelectSeatCell.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit

class SelectSeatCell: UICollectionViewCell {
    
    @IBOutlet weak var content: UIButton!
    var viewModel: SelectSeatProtocol!
    
    func configCell(_ indexPath: IndexPath, status: SeatStatus) {
        switch viewModel.cellType(indexPath) {
        case .empty:
            content.setTitle("", for: .normal)
            content.setImage(nil, for: .normal)
        case .number:
            content.setTitle(viewModel.rowNumber(indexPath.section), for: .normal)
            content.setImage(nil, for: .normal)
        case .seatType:
            content.setTitle(viewModel.typeString(indexPath.row), for: .normal)
            content.setImage(nil, for: .normal)
        case .seat:
            content.setTitle("", for: .normal)
            content.setImage(viewModel.cellImage(status), for: .normal)
        }
    }
}
