//
//  CuttingFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class CuttingFormDataStore: TrackingFormDataStore {
    override func recieved(lineItemParse: LineItemParse) {
        lineItemParse.isCut = true
        super.recieved(lineItemParse: lineItemParse)
    }
}
