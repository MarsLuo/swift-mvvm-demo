//
//  CheckInViewController.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit
import KRProgressHUD


class CheckInViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CheckInProtocol!
    
}

extension CheckInViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectSeatCell", for: indexPath)
        if let seatCell = cell as? SelectSeatCell {
            seatCell.viewModel = SelectSeatViewModel()
            seatCell.configCell(indexPath, status: viewModel.getSeatStatus(row: indexPath.row, section: indexPath.section))
        }
        return cell
    }
}

extension CheckInViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        KRProgressHUD.show()
        viewModel.bookSeat(index: indexPath) { (seat) in
            KRProgressHUD.dismiss()
            collectionView.reloadData()
        } failure: { (error) in
//            KRProgressHUD.dismiss()
            KRProgressHUD.showMessage(error.message)
        }
    }
}
