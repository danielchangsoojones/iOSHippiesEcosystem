//
//  SearchColorDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol SearchColorDataDelegate: MainSearchingDelegate {
    func successfullyCreatedCutList(for fabric: Fabric)
}

class SearchColorDataStore: MainSearchingDataStore {
    override func querySearchResults(text: String) {
        search(text: text, type: .color)
    }
    
    override func transform(results: Any) -> [Any] {
        if let fabricsParse = results as? [FabricParse] {
            let fabrics: [Fabric] = fabricsParse.map({ (fabricParse: FabricParse) -> Fabric in
                return Fabric(fabricParse: fabricParse)
            })
            return fabrics
        }
        
        return []
    }
    
    func getCutListFor(fabric: Fabric) {
        PFCloud.callFunction(inBackground: "getOneColorCutList", withParameters: ["color" : fabric.color], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results, let delegate = self.delegate as? SearchColorDataDelegate {
                delegate.successfullyCreatedCutList(for: fabric)
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        })
    }
}
