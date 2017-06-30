//
//  PackageParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class PackageParse: TrackParse, PFSubclassing {
    class func parseClassName() -> String {
        return "Package"
    }
    
    @NSManaged var state: String
}
