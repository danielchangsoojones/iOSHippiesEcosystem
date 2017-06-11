//
//  User.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Parse

class User: PFUser {
    //MARK- NSManaged properies
    @NSManaged fileprivate var firstName: String?
    @NSManaged fileprivate var lowercaseFirstName: String?
    @NSManaged var lastName: String?
    @NSManaged var lowercaseLastName: String?

    var theFirstName: String {
        get {
            return firstName ?? ""
        }
        set (newValue) {
            firstName = newValue
            lowercaseFirstName = newValue.lowercased()
        }
    }
    var theLastName: String {
        get {
            return lastName ?? ""
        }
        set (newValue) {
            lastName = newValue
            lowercaseLastName = newValue.lowercased()
        }
    }
    var fullName: String? {
        if let firstName = firstName, let lastName = lastName {
            return firstName + " " + lastName
        }
        return nil
    }
}
