//
//  AggregateInventoryDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol AggregateInventoryDataDelegate {
    func received(sizeGroups: [SizeGroup])
    func received(error: Error)
    func successfullySaved()
}

class AggregateInventoryDataStore {
    var delegate: AggregateInventoryDataDelegate?
    
    init(delegate: AggregateInventoryDataDelegate) {
        self.delegate = delegate
    }
}

//MARK: Load inventory counts
extension AggregateInventoryDataStore {
    func loadInventories(from productType: ProductType) {
        let query = ItemParse.query() as! PFQuery<ItemParse>
        query.whereKeyDoesNotExist("pick")
        
        let packageQuery = PackageParse.query()!
        packageQuery.whereKey("state", equalTo: Package.State.in_inventory.rawValue)
        query.whereKey("package", matchesQuery: packageQuery)
        
        let variantQuery = ProductVariantParse.query()!
        variantQuery.whereKey("product", equalTo: productType.productTypeParse)
        query.whereKey("productVariant", matchesQuery: variantQuery)
        
        query.limit = 10000
        query.includeKey("productVariant")
        query.findObjectsInBackground { (itemsParse, error) in
            if let itemsParse = itemsParse {
                let items = itemsParse.map({ (itemParse: ItemParse) -> Item in
                    let item = Item(itemParse: itemParse)
                    return item
                })
                let sizeGroups = self.createSizeGroups(from: items)
                self.delegate?.received(sizeGroups: sizeGroups)
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        }
    }
    
    private func createSizeGroups(from items: [Item]) -> [SizeGroup] {
        let sizeGroups: [SizeGroup] = createSizeGroups()
        for item in items {
            let index = sizeGroups.index(where: { (sizeGroup: SizeGroup) -> Bool in
                return sizeGroup.size == item.productVariant.size
            })
            if let index = index {
                sizeGroups[index].items.append(item)
            }
        }
        return sizeGroups
    }
    
    private func createSizeGroups() -> [SizeGroup] {
        let sizes = ProductVariant.sizes
        var sizeGroups: [SizeGroup] = []
        for size in sizes {
            let sizeGroup = SizeGroup(size: size)
            sizeGroups.append(sizeGroup)
        }
        return sizeGroups
    }
}

//MARK: Save Updated Counts
extension AggregateInventoryDataStore {
    func saveUpdatedCounts(from sizeGroups: [SizeGroup]) {
        let productVariantDictionary = createProductVariantDictionary(from: sizeGroups)
        PFCloud.callFunction(inBackground: "updateInventory", withParameters: ["variantDict" : productVariantDictionary], block: {
            (results: Any?, error: Error?) -> Void in
            if let _ = results {
                self.delegate?.successfullySaved()
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        })
    }
    
    private func createProductVariantDictionary(from sizeGroups: [SizeGroup]) -> [String : Int] {
        //[ProductVariantObjectID : delta]
        var variantDictionary : [String : Int] = [:]
        for sizeGroup in sizeGroups {
            let delta = sizeGroup.delta
            if let productVariantObjectID = sizeGroup.productVariant?.productVariantParse.objectId, delta != 0 {
                variantDictionary[productVariantObjectID] = delta
            }
        }
        return variantDictionary
    }
}
