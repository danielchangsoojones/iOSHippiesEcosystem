//
//  ShipLineItemDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol ShipLineItemsDataDelegate {
    func recieved(lineItems: [LineItem])
    func recieved(error: Error)
}

class ShipLineItemsDataStore {
    var delegate: ShipLineItemsDataDelegate?
    
    init(delegate: ShipLineItemsDataDelegate) {
        self.delegate = delegate
    }
    
    func loadLineItems(orderID: Int) {
        //we are using hasPrefix because some orders that were edited on Shopify were created with a new order number like #HippiesandHousewives2432<3A. We also only want open line items because if we didn't only find the open line items, then the first object recieved might only be the old order. For most orders, we should only get a single item returned.
        let query = LineItemParse.query() as! PFQuery<LineItemParse>
        query.whereKey("state", equalTo: "open")
        
        let orderQuery = OrderParse.query()!
        orderQuery.whereKey("name", hasPrefix: getOrderNames(from: orderID))
        query.whereKey("order", matchesQuery: orderQuery)
        
        query.findObjectsInBackground { (lineItemsParse, error) in
            if let lineItemsParse = lineItemsParse {
                let lineItems: [LineItem] = lineItemsParse.map({ (lineItemParse: LineItemParse) -> LineItem in
                    return LineItem(lineItemParse: lineItemParse)
                })
                self.delegate?.recieved(lineItems: lineItems)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
    
    fileprivate func getOrderNames(from orderID: Int) -> String {
        let prefix = "#HippiesandHousewives"
        let suffix = "<3"
        //i.e. #HippiesandHousewives3949<3
        let orderName = prefix + orderID.toString + suffix
        return orderName
    }
}
