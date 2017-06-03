//
//  Order.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Order: NSObject {
    var orderParse: OrderParse!
    var title: String {
        get {
            return orderParse.title
        }
        set {
            orderParse.title = newValue
        }
    }
    
    init(orderParse: OrderParse) {
        super.init()
        self.orderParse = orderParse
    }
}
