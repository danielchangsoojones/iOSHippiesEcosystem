//
//  SizeGroup.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class SizeGroup {
    var items: [Item] = []
    var size: String!
    var count: Int = 0
    
    var productVariant: ProductVariant? {
        if let item = items.first {
            return item.productVariant
        }
        return nil
    }
    var delta: Int {
        get {
            return count - items.count
        }
    }
    
    init(size: String) {
        self.size = size
    }
}
