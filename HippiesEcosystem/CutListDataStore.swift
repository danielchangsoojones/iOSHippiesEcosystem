//
//  CutListDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol CutListDataDelegate {
    func recieved(error: Error)
    func recieved(success: Bool)
}

class CutListDataStore {
    var delegate: CutListDataDelegate?
    
    init(delegate: CutListDataDelegate) {
        self.delegate = delegate
    }
    
    func getCutList() {
        PFCloud.callFunction(inBackground: "getCutList", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.recieved(success: true)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        })
    }
}
