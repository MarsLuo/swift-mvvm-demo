//
//  CheckInConfiger.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation

final class CheckInConfiger {
    static func configCheckIn(checkIn: CheckInViewController){
        let viewModel = CheckInViewModel(service: Service(host:"http://192.168.50.97:8080"))
        checkIn.viewModel = viewModel
    }
}
