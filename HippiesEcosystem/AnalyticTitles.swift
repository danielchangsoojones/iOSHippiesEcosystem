//
//  AnalyticTitles.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

enum AnalyticTitle: String {
    case openOrders = "Open Orders: "
    case itemsToCut = "# of items to cut: "
    case itemsToSew = "# of items to sew: "
    case allocatedInventoryCount = "# of allocated inventory: "
    case openPicks = "# of Orders to Pick: "
    case openShipping = "# of Orders to archive: "
    case lastShipped = "# of Orders shipped today: "
    
    static let all: [AnalyticTitle] = [.openOrders, .itemsToCut, .itemsToSew, .allocatedInventoryCount, .openPicks, .openShipping, .lastShipped]
}
