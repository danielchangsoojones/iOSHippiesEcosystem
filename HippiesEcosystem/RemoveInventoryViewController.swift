//
//  RemoveInventoryViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class RemoveInventoryViewController: InventoryManagementViewController {
    var dataStore: RemoveInventoryDataStore?
    var size: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
        updateRightBarButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: navigationItem.rightBarButtonItem?.action)
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = RemoveInventoryDataStore(delegate: self)
    }
    
    override func save(productType: ProductType, size: String) {
        self.size = size
        dataStore?.removeInventory(productType: productType, size: size)
    }
}

extension RemoveInventoryViewController: RemoveInventoryDataDelegate {
    func removed(inventory: Inventory) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Done") {
            self.popVC()
        }
        let size = self.size ?? ""
        let subTitle = "Removed: " + productType.title + "-" + size
        alertView.showSuccess("Success", subTitle: subTitle)
    }
    
    func recieved(error: Error) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        SCLAlertView().showError("Error", subTitle: error.localizedDescription)
    }
}
