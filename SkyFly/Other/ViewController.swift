//
//  ViewController.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckIn", let checkInViewController = segue.destination as? CheckInViewController {
            CheckInConfiger.configCheckIn(checkIn: checkInViewController)
        }
    }
}
