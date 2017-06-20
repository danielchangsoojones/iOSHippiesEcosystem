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
        let isCut = CutParse()
        isCut.user = User.current() ?? User()
        lineItemParse.item.isCut = isCut
        super.recieved(lineItemParse: lineItemParse)
    }
}
