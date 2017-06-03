//
//  LineItem.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class LineItem: NSObject {
    var isPicked: Bool {
        get {
            return lineItemParse.isPicked
        }
        set {
            lineItemParse.isPicked = newValue
        }
    }
    
    var lineItemParse: LineItemParse!
    
    init(lineItemParse: LineItemParse) {
        super.init()
        self.lineItemParse = lineItemParse
    }
}
