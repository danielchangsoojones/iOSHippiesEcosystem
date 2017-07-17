//
//  PickItemDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

protocol PickItemDataStoreDelegate {
    func successfulSave()
}

class PickItemDataStore {
    var delegate: PickItemDataStoreDelegate?
    
    init(delegate: PickItemDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func pick(pickable: Pickable) {
        save(lineItems: pickable.lineItems) { 
            self.delete(pickable)
        }
    }
    
    private func delete(_ pickable: Pickable) {
        pickable.pickableParse.deleteInBackground { (success, error) in
            if success {
                self.delegate?.successfulSave()
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        }
    }
    
    private func save(lineItems: [LineItem], completion: @escaping () -> ()) {
        var lineItemsParse: [LineItemParse] = []
        
        for lineItem in lineItems {
            lineItem.isPicked = true
            lineItemsParse.append(lineItem.lineItemParse)
        }
        
        LineItemParse.saveAll(inBackground: lineItemsParse) { (success, error) in
            if success {
                completion()
            } else if let error = error {
                SCLAlertView().showError("Error", subTitle: error.localizedDescription)
            }
        }
    }
}

extension PickItemDataStore {
    func loadItemStates(for lineItems: [LineItem]) {
        let itemObjectIDs: [String] = lineItems.map { (lineItem: LineItem) -> String in
            return lineItem.itemObjectID
        }
        let query = ItemParse.query() as! PFQuery<ItemParse>
        query.whereKey("objectId", containedIn: [itemObjectIDs])
        query.includeKey("package")
        query.selectKeys(["package"])
        query.limit = lineItems.count
        query.findObjectsInBackground { (itemParses, error) in
            if let itemParses = itemParses {
                
            } else if let error = error {
                print(error)
            }
        }
    }
    
    private func matchStates(to lineItems: [LineItem], from itemParses: [ItemParse]) -> [LineItem] {
        var lineItemsWithStates: [LineItem] = []
        for itemParse in itemParses {
            if let itemParseObjectID = itemParse.objectId {
                lineItems.index
                let index = lineItems.index(where: { (lineItem: LineItem) -> Bool in
                    let itemObjectId = lineItem.lineItemParse.item.objectId ?? ""
                    return itemObjectId == itemParseObjectID
                })
                if let index = index {
                    let matchingLineItem = lineItems[index]
                    
                }
            }
        }
    }
}
