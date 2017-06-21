//
//  MultipleCutsDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol MultipleCutsDataDelegate {
    func savedItems()
}

class MultipleCutsDataStore {
    var delegate: MultipleCutsDataDelegate?
    
    init(delegate: MultipleCutsDataDelegate) {
        self.delegate = delegate
    }
    
    func saveItemsFrom(productType: ProductType, size: String, quantity: Int) {
        let productTypeObjectID = productType.productTypeParse.objectId ?? ""
        PFCloud.callFunction(inBackground: "inputMassCuts", withParameters: ["productTypeObjectID" : productTypeObjectID, "size" : size, "quantity" : quantity], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.savedItems()
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        })
    }
}
