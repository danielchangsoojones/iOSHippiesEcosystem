//
//  Order.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Order: NSObject {
    enum ShipmentStatus: String {
        case open
        case internalShippingBin = "internal shipping bin"
    }
    
    var orderParse: OrderParse!
    var name: String {
        get {
            return orderParse.name
        }
        set {
            orderParse.name = newValue
        }
    }
    var shortName: String {
        get {
            let shortenedName = name.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890").inverted)
            return "#" + shortenedName
        }
    }
    var note: String? {
        get {
            return orderParse.note
        }
    }
    var address: Address {
        get {
            let address = Address(addressParse: orderParse.shippingAddress)
            return address
        }
    }
    var shipmentStatus: ShipmentStatus {
        get {
            if let status = ShipmentStatus(rawValue: orderParse.shipmentStatus) {
                return status
            }
            
            return .open
        }
        set {
            orderParse.shipmentStatus = newValue.rawValue
        }
    }
    var shopifyID: Double {
        get {
            return orderParse.shopifyID
        }
    }
    var lineItems: [LineItem] = []
    
    init(orderParse: OrderParse) {
        super.init()
        self.orderParse = orderParse
    }
}
