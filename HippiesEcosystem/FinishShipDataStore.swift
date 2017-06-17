//
//  FinishShipDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

protocol FinishShipDataDelegate {
    func shipped(order: Order)
    func received(error: Error)
}

class FinishShipDataStore {
    var delegate: FinishShipDataDelegate?
    
    init(delegate: FinishShipDataDelegate) {
        self.delegate = delegate
    }
    
    func ship(order: Order) {
        
    }
}
