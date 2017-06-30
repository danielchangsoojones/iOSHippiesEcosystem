//
//  PickOrderDataStore.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol PickOrderDataStoreDelegate {
    func recieved(_ pickables: [Pickable])
    func recieved(error: Error)
}

class PickOrderDataStore {
    var delegate: PickOrderDataStoreDelegate?
    
    init(delegate: PickOrderDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func getPickList() {
        PFCloud.callFunction(inBackground: "getPickList", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results {
                let pickables = self.parse(results: results)
                self.delegate?.recieved(pickables)
            } else if let error = error {
                self.delegate?.recieved(error: error)
            }
        })
    }
    
    private func parse(results: Any) -> [Pickable] {
        if let pickablesParse = results as? [PickableParse] {
            let pickables: [Pickable] = pickablesParse.map({ (pickableParse: PickableParse) -> Pickable in
                let pickable = Pickable(pickableParse: pickableParse)
                return pickable
            })
            let sortedPickables = sort(pickables)
            return sortedPickables
        }
        
        return []
    }
    
    private func sort(_ pickables: [Pickable]) -> [Pickable] {
        let sortedPickables = pickables.sorted { (previous: Pickable, next: Pickable) -> Bool in
            return previous.order.nameInt < next.order.nameInt
        }
        return sortedPickables
    }
}
