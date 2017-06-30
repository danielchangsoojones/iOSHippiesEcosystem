//
//  MultipleCutsViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class MultipleCutsViewController: QuantityManagementViewController {
    var dataStore: MultipleCutsDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = MultipleCutsDataStore(delegate: self)
    }
    
    override func save(productType: ProductType, size: String) {
        dataStore?.saveItemsFrom(productType: productType, size: size, quantity: quantity)
    }
}

extension MultipleCutsViewController: MultipleCutsDataDelegate {
    func savedItems() {
        popVC()
    }
}
