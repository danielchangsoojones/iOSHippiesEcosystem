//
//  QuantityManagementViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class QuantityManagementViewController: InventoryManagementViewController {
    var addingQuantityRow: InlinePickerRowFormer<FormInlinePickerCell, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        addingQuantityRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QuantityManagementViewController {
    var quantities: [Int] {
        var nums: [Int] = []
        for i in 1..<50 {
            nums.append(i)
        }
        return nums
    }
    
    var quantity: Int {
        return quantities[addingQuantityRow.selectedRow]
    }
    
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
