//
//  AppDelegateDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 7/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class AppDelegateDataStore {
    func updateAllocation() {
        PFCloud.callFunction(inBackground: "updateAllocation", withParameters: [:], block: {
            (_: Any?, error: Error?) -> Void in
            if let error = error {
                print(error)
            }
        })
    }
}
