//
//  Enviroment.swift
//  Food For All
//
//  Created by Daniel Jones on 1/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

enum Environment: String {
    case Staging = "staging"
    case Production = "production"
    
    var applicationId: String {
        switch self {
        case .Staging: return "hippiesAndHousewivesDevelop489305028"
        case .Production: return "hippiesAndHousewives123SHDJ4852"
        }
    }
    
    var server: String {
        switch self {
        case .Staging: return "https://hippies-and-housewives-develop.herokuapp.com/parse"
        case .Production: return "https://hippies-and-housewives.herokuapp.com/parse"
        }
    }
}
