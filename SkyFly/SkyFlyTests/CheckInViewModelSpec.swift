//
//  CheckInViewModelSpec.swift
//  CheckInViewModelSpec
//
//  Created by Yang Dev Luo on 2021/1/17.
//  Copyright © 2021 Thoughtworks. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import SkyFly

class CheckInViewModelSpec: QuickSpec {
    override func spec() {
        describe("test CheckInViewModelSpec") {
            it("book success ") {
                let data = CheckInSeat(id: "1", row: 3, section: 3, status: .yourSelect)
                let index = IndexPath(row: 3, section: 3)
                let viewModel = CheckInViewModel(service: StubService(error: nil, data: data))
                
                waitUntil { done in
                    viewModel.bookSeat(index: index) { (seat) in
                        expect(seat.row).to(equal(index.row))
                        expect(seat.section).to(equal(index.section))
                        expect(seat.status).to(equal(.yourSelect))
                        done()
                    } failure: { (message) in }
                    retry: { (message) in }
                }
            }
            
            it("seat had been book") {
                let error = SFError(code: "100001", message: "账户余额不足")
                let index = IndexPath(row: 3, section: 3)
                let viewModel = CheckInViewModel(service: StubService(error: error, data: nil))
                
                
                waitUntil { done in
                    viewModel.bookSeat(index: index) { (seat) in }
                        failure: { (message) in
                            expect(error.code).to(equal("100001"))
                            expect(error.message).to(equal("账户余额不足"))
                            done()
                        } retry: { (message) in }
                }
            }
            
            it("check failure by server down") {
                let error = SFError(code: "13", message: "服务器无法连接")
                let index = IndexPath(row: 3, section: 3)
                let viewModel = CheckInViewModel(service: StubService(error: error, data: nil))
                waitUntil { done in
                    viewModel.bookSeat(index: index) { (seat) in }
                        failure: { (message) in
                        } retry: { (message) in
                            expect(error.code).to(equal("13"))
                            expect(error.message).to(equal("服务器无法连接"))
                            expect(viewModel.retryIndex).notTo(beNil())
                            done()
                        }
                }
            }
        }
    }
}
