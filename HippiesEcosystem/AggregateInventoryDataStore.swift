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
        if let productTypeObjectID = productType.productTypeParse.objectId {
            PFCloud.callFunction(inBackground: "getInventoryCounts", withParameters: ["productTypeObjectID" : productTypeObjectID], block: {
                (results: Any?, error: Error?) -> Void in
                if let results = results as? [[Any]] {
                    let tuple = self.parse(results)
                    let sizeGroups = self.makeSizeGroups(productVariants: tuple.productVariants, items: tuple.items)
                    self.delegate?.received(sizeGroups: sizeGroups)
                } else if let error = error {
                    self.delegate?.received(error: error)
                }
            })
        }
    }
    
    private func makeSizeGroups(productVariants: [ProductVariant], items: [Item]) -> [SizeGroup] {
        let sizeGroups = createSizeGroups(from: productVariants)
        let updatedSizeGroups = self.update(sizeGroups, with: items)
        let sortedSizegroups = sort(updatedSizeGroups)
        return sortedSizegroups
    }
    
    private func parse(_ results: [[Any]]) -> (productVariants: [ProductVariant], items: [Item]) {
        var productVariants: [ProductVariant] = []
        var items: [Item] = []
        for result in results where !result.isEmpty {
            if let productVariantsParse = result as? [ProductVariantParse] {
                productVariants = map(productVariantsParse)
            } else if let itemsParse = result as? [ItemParse] {
                items = map(itemsParse)
            }
        }
        
        return (productVariants, items)
    }
    
    private func map(_ productVariantsParse: [ProductVariantParse]) -> [ProductVariant] {
        let productVariants = productVariantsParse.map { (p: ProductVariantParse) -> ProductVariant in
            return ProductVariant(productVariantParse: p)
        }
        return productVariants
    }
    
    private func map(_ itemsParse: [ItemParse]) -> [Item] {
        let items = itemsParse.map { (i: ItemParse) -> Item in
            return Item(itemParse: i)
        }
        return items
    }
    
    private func update(_ sizeGroups: [SizeGroup], with items: [Item]) -> [SizeGroup] {
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
    
    private func createSizeGroups(from productVariants: [ProductVariant]) -> [SizeGroup] {
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
