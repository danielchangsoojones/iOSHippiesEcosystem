//
//  ProductType.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ProductType: NSObject {
    var title: String = ""
    
    init(p: ProductTypeParse) {
        super.init()
        title = p.title
    }
}
