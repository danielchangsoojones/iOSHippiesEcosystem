//
//  CustomParseObject.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class CustomParseObject: PFObject {
    override static func query() -> PFQuery<PFObject>? {
        let query = super.query()
        query?.whereKey("isDeleted", notEqualTo: true)
        return query
    }
}

