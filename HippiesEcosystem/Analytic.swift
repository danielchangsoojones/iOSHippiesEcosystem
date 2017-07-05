//
//  File.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Analytic {
    var title: AnalyticTitle = .openOrders
    var count: Int = 0
    
    init(title: AnalyticTitle, count: Int) {
        self.title = title
        self.count = count
    }
}
