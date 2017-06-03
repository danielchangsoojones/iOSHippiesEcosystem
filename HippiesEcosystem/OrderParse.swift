//
//  OrderParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class OrderParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Order"
    }
    
    @NSManaged var title: String
}
