//
//  SewingFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class SewingFormDataStore: TrackingFormDataStore {
    override func recieved(lineItemParse: LineItemParse) {
        lineItemParse.isSewn = true
        super.recieved(lineItemParse: lineItemParse)
    }
}
