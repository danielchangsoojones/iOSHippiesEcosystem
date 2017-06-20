//
//  ItemParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ItemParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Item"
    }
    
    @NSManaged var productVariant: ProductVariantParse
    @NSManaged var lineItem: LineItemParse
    @NSManaged var isCut: CutParse
}
