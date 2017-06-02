//
//  FabricParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class FabricParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Fabric"
    }
    
    @NSManaged var color: String
}
