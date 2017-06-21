//
//  SewingFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class SewingFormDataStore: TrackingFormDataStore {
    override func recieved(itemParse: ItemParse) {
        if let currentUser = User.current() {
            let sewnParse = SewnParse()
            sewnParse.addUniqueObject(currentUser, forKey: "users")
            itemParse.sewn = sewnParse
            super.recieved(itemParse: itemParse)
        }
    }
}
