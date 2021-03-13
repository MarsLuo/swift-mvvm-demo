//
//  CheckInViewController.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit
import KRProgressHUD
import Alamofire

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var retryButton: UIButton!
    
    var viewModel: CheckInProtocol!
    
    @IBAction func retryAction(_ sender: Any) {
        if let index = viewModel.retryIndex {
            bookSeat(index: index)
        }
    }
    
    func bookSeat(index: IndexPath){
        KRProgressHUD.show()
        viewModel.bookSeat(index: index) { (seat) in
            KRProgressHUD.dismiss()
            self.collectionView.reloadData()
            self.retryButton.isHidden = true
        } failure: { (error) in
            KRProgressHUD.showMessage(error.message)
            if error.code == CheckInViewModel.changeSeatCode {
                self.retryButton.isHidden = true
                self.collectionView.reloadData()
            } else {
                self.viewModel.retryIndex = index
                self.retryButton.isHidden = false
                self.retryButton.setTitle(self.viewModel.retryTitle(row: index.row, section: index.section), for: .normal)
            }
        }
    }
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
            seatCell.configCell(indexPath, status: viewModel.getSeatStatus(row: indexPath.row, section: indexPath.section))
        }
        return cell
    }
}

extension CheckInViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     bookSeat(index: indexPath)
    }
}
