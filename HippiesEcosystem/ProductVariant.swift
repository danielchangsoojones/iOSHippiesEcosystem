//
//  ProductVariant.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ProductVariant: NSObject {
    var productVariantParse: ProductVariantParse!
    
    init(productVariantParse: ProductVariantParse) {
        super.init()
        self.productVariantParse = productVariantParse
    }
}
