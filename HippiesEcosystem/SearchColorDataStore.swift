//
//  SearchColorDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

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
}
