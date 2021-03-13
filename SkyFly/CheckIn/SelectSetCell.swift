//
//  SelectSetCell.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit

class SelectSetCell: UICollectionViewCell {
    
    @IBOutlet weak var content: UIButton!
    var viewModel: SelectSetProtocol!
    
    func configCell(_ indexPath: IndexPath) {
        switch viewModel.cellType(indexPath) {
        case .empty:
            content.setTitle("", for: .normal)
            content.setImage(nil, for: .normal)
        case .number:
            content.setTitle(viewModel.rowNumber(indexPath.section), for: .normal)
            content.setImage(nil, for: .normal)
        case .setType:
            content.setTitle(viewModel.typeString(indexPath.row), for: .normal)
            content.setImage(nil, for: .normal)
        case .set:
            content.setTitle("", for: .normal)
            content.setImage(viewModel.cellImage(.selected), for: .normal)
        }
    }
}
