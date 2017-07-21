//
//  AnalyticTitles.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

enum AnalyticTitle: String {
    case openOrders = "Open Orders"
    case newestOrders = "Orders since midnight"
    case newestItems = "Items ordered since midnight"
    case newestItemsCost = "Cost to make above items($15)"
    case itemsToCut = "# of items to cut"
    case itemsToSew = "# of items to sew"
    case allocatedInventoryCount = "# of allocated inventory"
    case openPicks = "# of Orders to Pick"
    case openShipping = "# of Orders to archive"
    case lastShippedOrders = "# of Orders shipped today"
    case lastShippedItems = "# of Items shipped today"
    
    init(apiString: String) {
        var currentCase: AnalyticTitle = .openOrders
        switch(apiString) {
        case "openOrders":
            currentCase = .openOrders
        case "newestOrders":
            currentCase = .newestOrders
        case "newestItems":
            currentCase = .newestItems
        case "newestItemsCost":
            currentCase = .newestItemsCost
        case "itemsToCut":
            currentCase = .itemsToCut
        case "itemsToSew":
            currentCase = .itemsToSew
        case "allocatedInventoryCount":
            currentCase = .allocatedInventoryCount
        case "openPicks":
            currentCase = .openPicks
        case "openShipping":
            currentCase = .openShipping
        case "lastShippedOrders":
            currentCase = .lastShippedOrders
        case "lastShippedItems":
            currentCase = .lastShippedItems
        default:
            print("Error: we received an API string for an analytics category that does not exist")
        }
        
        self = currentCase
    }
    
    static let all: [AnalyticTitle] = [.openOrders, .newestOrders, .newestItems, .newestItemsCost, .itemsToCut, .itemsToSew, .allocatedInventoryCount, .openPicks, .openShipping, .lastShippedOrders, .lastShippedItems]
}
