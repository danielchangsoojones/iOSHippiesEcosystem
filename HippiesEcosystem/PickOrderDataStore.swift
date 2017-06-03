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
//                self.delegate?.recieved(orders: <#T##[Order]#>, orderDictionary: <#T##[Order : [LineItem]]#>)
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
                if let innerArray = innerArray as? NSArray, let order = innerArray[0] as? Order, let lineItems = innerArray[1] as? [LineItem] {
                    orders.append(order)
                    orderDictionary[order] = lineItems
                }
            }
        }
        return (orders, orderDictionary)
    }
}
