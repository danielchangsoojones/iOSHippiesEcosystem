//
//  PickableParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class PickableParse: CustomParseObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Pickable"
    }
    
    @NSManaged var order: OrderParse
    @NSManaged var lineItems: [LineItemParse]
}

