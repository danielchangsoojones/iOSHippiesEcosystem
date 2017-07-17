//
//  Item.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Item {
    var package: Package? {
        print(itemParse.package)
        if let packageParse = itemParse.package {
            return Package(packageParse: packageParse)
        } else {
            return nil
        }
    }
    var packageState: Package.State {
        get {
            return package?.state ?? .unknown
        }
    }
    var productVariant: ProductVariant {
        get {
            let productVariant = ProductVariant(productVariantParse: itemParse.productVariant)
            return productVariant
        }
    }
    var itemParse: ItemParse!
    
    init(itemParse: ItemParse) {
        self.itemParse = itemParse
    }
}
