//
//  Fabric.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Fabric: NSObject {
    var color: String {
        get {
            return fabricParse.color
        }
    }
    
    var fabricParse: FabricParse!
    
    init(fabricParse: FabricParse) {
        super.init()
        self.fabricParse = fabricParse
    }
}
