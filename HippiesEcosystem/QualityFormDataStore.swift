//
//  QualityFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class QualityFormDataStore: TrackingFormDataStore {
    override func recieved(lineItemParse: LineItemParse) {
        //Once a line item has been quality checked then it is fully placed in it's shipping bag to leave the Hippies and Housewives facility
        lineItemParse.isShipped = true
        super.recieved(lineItemParse: lineItemParse)
    }
}
