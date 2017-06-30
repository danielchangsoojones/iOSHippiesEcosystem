//
//  ProductVariant.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ProductVariant: NSObject {
    var size: String {
        get {
            return productVariantParse.size
        }
    }
    var productVariantParse: ProductVariantParse!
    
    init(productVariantParse: ProductVariantParse) {
        super.init()
        self.productVariantParse = productVariantParse
    }
}

extension ProductVariant {
    static let sizes = ["XS", "S", "M", "L", "XL", "XXL", "One Size"]
}
