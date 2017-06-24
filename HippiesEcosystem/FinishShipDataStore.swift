//
//  FinishShipDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

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
        order.shipmentStatus = .internalShippingBin
        var objectArray: [PFObject] = [order.orderParse]
        for lineItem in order.lineItems {
            lineItem.isShipped = true
            lineItem.state = .archived
            objectArray.append(lineItem.lineItemParse)
        }
        
        
        //Be careful on your development database because if you archive an order, it will actually archive the order on shopify.
        PFObject.saveAll(inBackground: objectArray) { (success, error) in
            if success {
                PFCloud.callFunction(inBackground: "archiveShopifyOrder", withParameters: ["shopifyOrderID": order.shopifyID], block: {
                    (result: Any?, error: Error?) -> Void in
                    if let success = result as? Bool, success {
                        self.delegate?.shipped(order: order)
                    } else if let error = error {
                        self.delegate?.received(error: error)
                    }
                })
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        }
    }
}
