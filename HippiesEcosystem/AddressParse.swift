//
//  AddressParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class AddressParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Address"
    }
    
    @NSManaged var name: String
    @NSManaged var note: String?
}
