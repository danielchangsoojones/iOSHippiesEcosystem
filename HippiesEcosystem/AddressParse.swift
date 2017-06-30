//
//  AddressParse.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class AddressParse: CustomParseObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Address"
    }
    
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phone: String
    @NSManaged var addressOne: String
    @NSManaged var addressTwo: String?
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var zip: String
    @NSManaged var country: String
}
