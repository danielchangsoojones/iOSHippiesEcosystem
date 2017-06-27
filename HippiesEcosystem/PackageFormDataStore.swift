//
//  PackageFormDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class PackageFormDataStore: TrackingFormDataStore {
    override func save(id: Double) {
        PFCloud.callFunction(inBackground: "inputPackage", withParameters: ["uniqueItemID": id], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.successfullySaved()
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        })
    }
    
    override func recieved(itemParse: ItemParse) {
        let package = Package()
        package.state = .waiting_for_identified_pick
        itemParse.package = package.packageParse
        super.recieved(itemParse: itemParse)
    }
}
