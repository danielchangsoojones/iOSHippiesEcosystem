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
        let query = ItemParse.query() as! PFQuery<ItemParse>
        query.whereKey("uniqueID", equalTo: id)
        query.getFirstObjectInBackground { (itemParse, error) in
            if let itemParse = itemParse {
                self.recieved(itemParse: itemParse)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
    
    func recieved(itemParse: ItemParse) {
        save(itemParse: itemParse)
    }
    
    fileprivate func save(itemParse: ItemParse) {
        itemParse.saveInBackground { (success, error) in
            if success {
                self.delegate?.successfullySaved()
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        }
    }
}
