//
//  PackageFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class PackageFormDataStore: TrackingFormDataStore {
    override func recieved(lineItemParse: LineItemParse) {
        lineItemParse.isPackaged = true
        super.recieved(lineItemParse: lineItemParse)
    }
}
