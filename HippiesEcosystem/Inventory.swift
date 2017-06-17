//
//  Inventory.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Inventory {
    var title: String {
        get {
           return inventoryParse.productVariant.productType.title
        }
    }
    var size: String {
        get {
            return inventoryParse.productVariant.size
        }
    }
    var inventoryParse: InventoryParse!
    
    init(inventoryParse: InventoryParse) {
        self.inventoryParse = inventoryParse
    }
}
