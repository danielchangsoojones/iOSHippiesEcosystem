//
//  QualityFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class QualityFormDataStore: TrackingFormDataStore {
    override func recieved(lineItemParse: LineItemParse) {
        //Once a line item has been quality checked then it is fully placed in it's shipping bag to leave the Hippies and Housewives facility
        //TODO: can I pass an entire Parse Object to a Cloud code function? I don't think I can, but would be more effecient.
        lineItemParse.isShipped = true
        
        lineItemParse.saveInBackground { (success, error) in
            if success {
                self.checkIfItemShouldArchive(lineItemParse: lineItemParse)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
    
    func checkIfItemShouldArchive(lineItemParse: LineItemParse) {
        let orderID = lineItemParse.order.objectId ?? ""
        PFCloud.callFunction(inBackground: "tryLineItemsArchive", withParameters: ["orderID": orderID], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.successfullySaved()
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        })
    }
}
