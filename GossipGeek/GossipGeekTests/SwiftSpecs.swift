//
//  SwiftSpecs.swift
//  GossipGeek
//
//  Created by Yang Luo on 07/08/2017.
//  Copyright © 2017 cozhang . All rights reserved.
//


import Quick
import Nimble

class BananaViewControllerSpec: QuickSpec {
    override func spec() {
        
        describe("Demo Case") {
            it("sets the banana count label to zero") {
                expect("0").to(equal("0"))
            }
        }
    }
}
