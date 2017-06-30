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
    var count: Int = 0
    var size: String {
        get {
            return productVariant.size
        }
    }
    var delta: Int {
        get {
            return count - items.count
        }
    }
    var productVariant: ProductVariant!
    
    init(productVariant: ProductVariant) {
        self.productVariant = productVariant
    }
    
    func setOriginalCount() {
        self.count = items.count
    }
}
