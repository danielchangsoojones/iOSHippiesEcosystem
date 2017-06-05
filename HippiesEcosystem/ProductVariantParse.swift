//
//  ProductVariantParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ProductVariantParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "ProductVariant"
    }
    
    @NSManaged var size: String
}
