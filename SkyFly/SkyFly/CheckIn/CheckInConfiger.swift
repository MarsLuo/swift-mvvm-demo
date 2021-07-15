//
//  CheckInConfiger.swift
//  SkyFly
//
//  Created by Yang Dev Luo on 2021/3/13.
//

import Foundation

final class CheckInConfiger {
    static func configCheckIn(checkIn: CheckInViewController){
        let viewModel = CheckInViewModel(service: Service(host:"http://localhost:8080", client: AFNetWorkImp()))
        checkIn.viewModel = viewModel
    }
}
