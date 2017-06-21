//
//  InputInventoryViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former
import SCLAlertView

class InputInventoryViewController: QuantityManagementViewController {
    var dataStore: InputInventoryDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = InputInventoryDataStore(delegate: self)
    }
    
    override func save(productType: ProductType, size: String) {
        dataStore?.saveInventory(productType: productType, quantity: quantity, size: size)
    }
}

extension InputInventoryViewController: InputInventoryDataDelegate {
    func successfullySavedInventory() {
        popVC()
    }
    
    func received(error: Error) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        SCLAlertView().showError("Error saving", subTitle: error.localizedDescription)
    }
}
