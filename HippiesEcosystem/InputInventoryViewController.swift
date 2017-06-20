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

class InputInventoryViewController: InventoryManagementViewController {
    var addingQuantityRow: InlinePickerRowFormer<FormInlinePickerCell, Int>!
    
    var dataStore: InputInventoryDataStore?
    
    let quantities: [Int] = [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12, 13, 14, 15]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
        addingQuantityRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = InputInventoryDataStore(delegate: self)
    }
    
    override func save(productType: ProductType, size: String) {
        let quantity = quantities[addingQuantityRow.selectedRow]
        dataStore?.saveInventory(productType: productType, quantity: quantity, size: size)
    }
}

extension InputInventoryViewController {
    fileprivate func addingQuantityRowSetup() {
        addingQuantityRow = InlinePickerRowFormer<FormInlinePickerCell, Int>(cellSetup: nil)
        addingQuantityRow.configure { (row) in
            row.pickerItems = quantities.map {
                return InlinePickerItem(title: $0.toString, value: $0)
            }
        }
        
        _ = append(rows: [addingQuantityRow], headerTitle: "nums")
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
