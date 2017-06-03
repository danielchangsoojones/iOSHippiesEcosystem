//
//  PickItemDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol PickItemDataStoreDelegate {
    func successfulSave()
}

class PickItemDataStore {
    var delegate: PickItemDataStoreDelegate?
    
    init(delegate: PickItemDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func save(lineItems: [LineItem]) {
        var lineItemsParse: [LineItemParse] = []
        
        for lineItem in lineItems {
            lineItem.isPicked = true
            lineItemsParse.append(lineItem.lineItemParse)
        }
        
        LineItemParse.saveAll(inBackground: lineItemsParse) { (success, error) in
            if success {
                self.delegate?.successfulSave()
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        }
    }
}
