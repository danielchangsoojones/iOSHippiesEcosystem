//
//  LineItem.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class LineItem: NSObject {
    var isPicked: Bool {
        get {
            return lineItemParse.isPicked
        }
        set {
            lineItemParse.isPicked = newValue
        }
    }
    var shopifyID: String {
        get {
            let removedZeroID = String(format: "%g", lineItemParse.shopifyLineItemID)
            return removedZeroID
        }
    }
    var size: String {
        get {
            return lineItemParse.variant_title
        }
    }
    var title: String {
        get {
            return lineItemParse.title
        }
    }
    var order: Order {
        get {
            let order = Order(orderParse: lineItemParse.order)
            return order
        }
    }
    
    var lineItemParse: LineItemParse!
    
    init(lineItemParse: LineItemParse) {
        super.init()
        self.lineItemParse = lineItemParse
    }
}
