//
//  PackageFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class PackageFormDataStore: TrackingFormDataStore {
    override func recieved(itemParse: ItemParse) {
        let package = Package()
        package.state = .waiting_for_identified_pick
        itemParse.package = package.packageParse
        super.recieved(itemParse: itemParse)
    }
}
