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
    override func recieved(itemParse: ItemParse) {
        let isCut = CutParse()
        isCut.user = User.current() ?? User()
        itemParse.isCut = isCut
        super.recieved(itemParse: itemParse)
    }
}
