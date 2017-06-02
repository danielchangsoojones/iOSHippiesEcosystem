//
//  ProductType.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ProductType: NSObject {
    var title: String {
        get {
            return productTypeParse.title
        }
        set {
            productTypeParse.title = newValue
            productTypeParse.lowercaseTitle = newValue.lowercased()
        }
    }
    var productTypeParse: ProductTypeParse!
    
    init(p: ProductTypeParse) {
        super.init()
        productTypeParse = p
    }
}
