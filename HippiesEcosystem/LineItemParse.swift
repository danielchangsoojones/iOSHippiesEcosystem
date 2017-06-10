//
//  LineItemParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class LineItemParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "LineItem"
    }
    
    @NSManaged var shopifyLineItemID: Double
    @NSManaged var quantity: Int
    @NSManaged var state: String
    @NSManaged var isCut: Bool
    @NSManaged var isSewn: Bool
    @NSManaged var isPackaged: Bool
    @NSManaged var isPicked: Bool
    @NSManaged var isShipped: Bool
    @NSManaged var title: String
    @NSManaged var variant_title: String
    @NSManaged var productVariant: ProductVariantParse
    @NSManaged var order: OrderParse
}
