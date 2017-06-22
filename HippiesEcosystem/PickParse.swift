//
//  PickParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class PickParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Pick"
    }
    
    @NSManaged var user: User
}
