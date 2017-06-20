//
//  InputInventoryDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol InputInventoryDataDelegate {
    func successfullySavedInventory()
    func received(error: Error)
}

class InputInventoryDataStore {
    var delegate: InputInventoryDataDelegate?
    
    init(delegate: InputInventoryDataDelegate) {
        self.delegate = delegate
    }
    
    func saveInventory(productType: ProductType, quantity: Int, size: String) {
        let productTypeObjectID = productType.productTypeParse.objectId ?? ""
        PFCloud.callFunction(inBackground: "saveInventory", withParameters: ["productTypeObjectID" : productTypeObjectID, "quantity" : quantity, "size" : size], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.successfullySavedInventory()
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        })
    }
}
