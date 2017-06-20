//
//  TrackingFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol TrackingFormDataDelegate {
    func successfullySaved()
    func recieved(error: Error)
}

class TrackingFormDataStore {
    var delegate: TrackingFormDataDelegate?
    
    init(delegate: TrackingFormDataDelegate) {
        self.delegate = delegate
    }
    
    func save(id: Double) {
        //override in subclasses
        let query = ItemParse.query() as! PFQuery<ItemParse>
        query.whereKey("uniqueID", equalTo: id)
        query.getFirstObjectInBackground { (lineItemParse, error) in
            if let lineItemParse = lineItemParse {
                self.recieved(lineItemParse: lineItemParse)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
    
    func recieved(lineItemParse: LineItemParse) {
        save(lineItemParse: lineItemParse)
    }
    
    fileprivate func save(lineItemParse: LineItemParse) {
        lineItemParse.saveInBackground { (success, error) in
            if success {
                self.delegate?.successfullySaved()
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
}
