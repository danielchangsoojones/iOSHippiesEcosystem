//
//  SewnParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class SewnParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Sewn"
    }
    
    @NSManaged var users: [User]
}
