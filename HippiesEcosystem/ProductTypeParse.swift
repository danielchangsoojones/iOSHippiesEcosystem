//
//  ProductTypeParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ProductTypeParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "ProductType"
    }
    
    @NSManaged var title: String
    @NSManaged var lowercaseTitle: String
    @NSManaged var fabric: FabricParse
    @NSManaged var vendor: String
    @NSManaged var shopifyID: Double
}

