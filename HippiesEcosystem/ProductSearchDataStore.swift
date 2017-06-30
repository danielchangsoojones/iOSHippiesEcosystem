//
//  ProductSearchDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ProductSearchDataStore: MainSearchingDataStore {
    override func querySearchResults(text: String) {
        search(text: text, type: .productType)
    }
    
    override func transform(results: Any) -> [Any] {
        if let productTypeParses = results as? [ProductTypeParse] {
            let productTypes = productTypeParses.map({ (p: ProductTypeParse) -> ProductType in
                return ProductType(p: p)
            })
            return productTypes
        }
        
        return []
    }
}
