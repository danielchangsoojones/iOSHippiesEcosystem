//
//  LineItem.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class LineItem: NSObject {
    enum State: String {
        case open
        case archived
    }
    
    var state: State {
        get {
            if let state = State(rawValue: lineItemParse.state) {
                return state
            }
            
            return .open
        }
        set {
            lineItemParse.state = newValue.rawValue
        }
    }
    var isPicked: Bool {
        get {
            return lineItemParse.pick != nil
        }
        set {
            if newValue && lineItemParse.pick == nil {
                let pickParse = PickParse()
                if let currentUser = User.current() {
                    pickParse.user = currentUser
                }
                lineItemParse.pick = pickParse
            }
        }
    }
    var isShipped: Bool {
        get {
            return lineItemParse.ship != nil
        }
        set {
            if newValue && lineItemParse.ship == nil {
                let shipParse = ShipParse()
                if let currentUser = User.current() {
                    shipParse.user = currentUser
                }
                lineItemParse.ship = shipParse
            }
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
    var quantity: Int {
        get {
            return lineItemParse.quantity
        }
    }
    var itemObjectID: String {
        get {
            return lineItemParse.item.objectId ?? ""
        }
    }
    private var _packageState: Package.State = .unknown
    var packageState: Package.State {
        get {
            return _packageState
        }
        set {
            _packageState = newValue
        }
    }
    
    
    var lineItemParse: LineItemParse!
    
    init(lineItemParse: LineItemParse) {
        super.init()
        self.lineItemParse = lineItemParse
    }
}
