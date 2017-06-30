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
    var sizeGroups: [SizeGroup] = []
    var delegate: AggregateInventoryDataDelegate?
    
    init(delegate: AggregateInventoryDataDelegate) {
        self.delegate = delegate
    }
}

//MARK: Load inventory counts
extension AggregateInventoryDataStore {
    //TODO: this is probably much better to run in cloud code, since we run a double query
    func loadInventories(from productType: ProductType) {
        let productVariantQuery = ProductVariantParse.query()! as! PFQuery<ProductVariantParse>
        productVariantQuery.whereKey("product", equalTo: productType.productTypeParse)
        productVariantQuery.findObjectsInBackground { (productVariantsParse, error) in
            if let productVariantsParse = productVariantsParse {
                let productVariants = productVariantsParse.map({ (p: ProductVariantParse) -> ProductVariant in
                    return ProductVariant(productVariantParse: p)
                })
                self.sizeGroups = self.createSizeGroups(productVariants: productVariants)
                self.loadItems(from: productType)
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        }
    }
    
    func loadItems(from productType: ProductType) {
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
                let sizeGroups = self.updateSizeGroups(with: items)
                self.delegate?.received(sizeGroups: sizeGroups)
            } else if let error = error {
                self.delegate?.received(error: error)
            }
        }
    }
    
    private func updateSizeGroups(with items: [Item]) -> [SizeGroup] {
        for item in items {
            let index = sizeGroups.index(where: { (sizeGroup: SizeGroup) -> Bool in
                return sizeGroup.size == item.productVariant.size
            })
            if let index = index {
                sizeGroups[index].items.append(item)
                sizeGroups[index].setOriginalCount()
            }
        }
        return sizeGroups
    }
    
    private func createSizeGroups(productVariants: [ProductVariant]) -> [SizeGroup] {
        var sizeGroups: [SizeGroup] = []
        for productVariant in productVariants {
            let sizeGroup = SizeGroup(productVariant: productVariant)
            sizeGroups.append(sizeGroup)
        }
        let sortedSizeGroups = sort(sizeGroups)
        return sortedSizeGroups
    }
    
    private func sort(_ sizeGroups: [SizeGroup]) -> [SizeGroup] {
        let sizes = ProductVariant.sizes
        return sizeGroups.sorted(by: { (current: SizeGroup, next: SizeGroup) -> Bool in
            let currentIndex: Int = sizes.index(of: current.size) ?? 0
            let nextIndex: Int = sizes.index(of: next.size) ?? 0
            return nextIndex > currentIndex
        })
    }
}

//MARK: Save Updated Counts
extension AggregateInventoryDataStore {
    func saveUpdatedCounts(from sizeGroups: [SizeGroup]) {
        let productVariantDictionary = createProductVariantDictionary(from: sizeGroups)
        if !productVariantDictionary.isEmpty {
            PFCloud.callFunction(inBackground: "updateInventoryCount", withParameters: ["variantDict" : productVariantDictionary], block: {
                (results: Any?, error: Error?) -> Void in
                if let _ = results {
                    self.delegate?.successfullySaved()
                } else if let error = error {
                    self.delegate?.received(error: error)
                }
            })
        } else {
            self.delegate?.successfullySaved()
        }
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
