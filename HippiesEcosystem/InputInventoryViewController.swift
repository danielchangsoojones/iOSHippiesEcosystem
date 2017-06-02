//
//  InputInventoryViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class InputInventoryViewController: UIViewController {
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    lazy var former: Former = Former(tableView: self.tableView)
    
    var sizeRow: InlinePickerRowFormer<FormInlinePickerCell, String>!
    var addingQuantityRow: InlinePickerRowFormer<FormInlinePickerCell, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        rightBarButtonItemSetup()
        sizeRowSetup()
        addingQuantityRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func tableViewSetup() {
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    fileprivate func append(rows: [RowFormer], headerTitle: String) -> SectionFormer? {
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = headerTitle
        let section = SectionFormer(rowFormers: rows)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
        return section
    }
}

extension InputInventoryViewController {
    fileprivate func sizeRowSetup() {
        let sizes = ["XS", "S", "M", "L", "XL", "XXL", "One Size"]
        sizeRow = InlinePickerRowFormer<FormInlinePickerCell, String>(cellSetup: {
            $0.titleLabel.text = "Size"
        })
        sizeRow.configure { (row) in
            row.pickerItems = sizes.map {
                InlinePickerItem(title: $0)
            }
        }
        
        _ = append(rows: [sizeRow], headerTitle: "Category")
    }
    
    fileprivate func addingQuantityRowSetup() {
        let nums: [Int] = [1, 2, 3, 4, 5, 6, 7, 8 , 9, 10, 11, 12, 13, 14, 15, -1, -2, -3]
        addingQuantityRow = InlinePickerRowFormer<FormInlinePickerCell, Int>(cellSetup: nil)
        addingQuantityRow.configure { (row) in
            row.pickerItems = nums.map {
                return InlinePickerItem(title: $0.toString, value: $0)
            }
        }
        
        _ = append(rows: [addingQuantityRow], headerTitle: "nums")
    }
}



extension InputInventoryViewController {
    fileprivate func rightBarButtonItemSetup() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(sender:)))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func save(sender: UIBarButtonItem) {
        //TODO: save in data store
    }
}
