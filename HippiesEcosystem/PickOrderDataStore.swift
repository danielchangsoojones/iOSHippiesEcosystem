//
//  PickOrderDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol PickOrderDataStoreDelegate {
    func recieved(orders: [Order], orderDictionary: [Order : [LineItem]])
    func recieved(error: Error)
}

class PickOrderDataStore {
    var delegate: PickOrderDataStoreDelegate?
    
    init(delegate: PickOrderDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func getPickList() {
        PFCloud.callFunction(inBackground: "getPickList", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results {
                let tuple = self.parse(results: results)
                self.delegate?.recieved(orders: tuple.orders, orderDictionary: tuple.orderDictionary)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        })
    }
    
    private func parse(results: Any) -> (orders: [Order], orderDictionary: [Order : [LineItem]]) {
        var orders: [Order] = []
        var orderDictionary: [Order : [LineItem]] = [:]
        
        if let array = results as? NSArray {
            for innerArray in array {
                if let innerArray = innerArray as? NSArray, let orderParse = innerArray[0] as? OrderParse, let lineItemsParse = innerArray[1] as? [LineItemParse] {
                    let order = Order(orderParse: orderParse)
                    let lineItems = lineItemsParse.map({ (lineItemParse: LineItemParse) -> LineItem in
                        return LineItem(lineItemParse: lineItemParse)
                    })
                    orders.append(order)
                    orderDictionary[order] = lineItems
                }
            }
        }
        return (orders, orderDictionary)
    }
}
