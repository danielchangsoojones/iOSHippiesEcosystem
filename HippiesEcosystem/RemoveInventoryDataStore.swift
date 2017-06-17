//
//  RemoveInventoryDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol RemoveInventoryDataDelegate {
    func removed(inventory: Inventory)
    func recieved(error: Error)
}

class RemoveInventoryDataStore {
    var delegate: RemoveInventoryDataDelegate?
    
    init(delegate: RemoveInventoryDataDelegate) {
        self.delegate = delegate
    }
    
    func removeInventory(productType: ProductType, size: String) {
        if let productTypeObjectID = productType.productTypeParse.objectId {
            PFCloud.callFunction(inBackground: "removeInventory", withParameters: ["productTypeObjectID": productTypeObjectID, "size" : size], block: {
                (result: Any?, error: Error?) -> Void in
                if let inventoryParse = result as? InventoryParse {
                    let inventory = Inventory(inventoryParse: inventoryParse)
                    self.delegate?.removed(inventory: inventory)
                } else if let error = error {
                    self.delegate?.recieved(error: error)
                }
            })
        }
    }
}
