//
//  Package.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Package {
    enum State: String {
        case waiting_for_identified_pick = "waiting for identified pick"
        case in_inventory = "in inventory"
        case unknown
        
        var displayName: String {
            switch self {
            case .waiting_for_identified_pick:
                return "in packaged suits bin or bag"
            default:
                return self.rawValue
            }
        }
    }
    var state: State {
        get {
            return State(rawValue: packageParse.state) ?? .in_inventory
        }
        set {
            packageParse.state = newValue.rawValue
        }
    }
    var packageParse: PackageParse!
    
    init(packageParse: PackageParse) {
        self.packageParse = packageParse
        if let currentUser = User.current() {
            packageParse.user = currentUser
        }
    }
    
    convenience init() {
        self.init(packageParse: PackageParse())
    }
}
