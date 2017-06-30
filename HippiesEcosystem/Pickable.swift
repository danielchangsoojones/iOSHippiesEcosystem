//
//  Pickable.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Pickable {
    var order: Order {
        get {
            let order = Order(orderParse: pickableParse.order)
            return order
        }
    }
    var lineItems: [LineItem] {
        get {
            let lineItems = pickableParse.lineItems.map { (lineItemParse: LineItemParse) -> LineItem in
                let lineItem = LineItem(lineItemParse: lineItemParse)
                return lineItem
            }
            return lineItems
        }
    }
    var pickableParse: PickableParse!
    
    init(pickableParse: PickableParse) {
        self.pickableParse = pickableParse
    }
}
