//
//  CutDistribution.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 7/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class CutDistribution {
    var color: String {
        get {
            return fabricParse.color
        }
    }
    var count: Int = 0
    var fabricParse: FabricParse!
    
    init(fabric: FabricParse, count: Int) {
        self.fabricParse = fabric
        self.count = count
    }
}
