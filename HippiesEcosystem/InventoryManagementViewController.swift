//
//  InventoryManagementViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class InventoryManagementViewController: UIViewController {    
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    lazy var former: Former = Former(tableView: self.tableView)
    var sizeRow: InlinePickerRowFormer<FormInlinePickerCell, String>!
    
    var productType: ProductType!
    let sizes = ProductVariant.sizes
    
    init(productType: ProductType) {
        super.init(nibName: nil, bundle: nil)
        self.productType = productType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        rightBarButtonSetup()
        sizeRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func tableViewSetup() {
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    func save(productType: ProductType, size: String) {
        fatalError("must override in subclasses")
    }
}

//MARK: Former rows
extension InventoryManagementViewController {
    func append(rows: [RowFormer], headerTitle: String) -> SectionFormer? {
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = headerTitle
        let section = SectionFormer(rowFormers: rows)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
        return section
    }
    
    fileprivate func sizeRowSetup() {
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
}

extension InventoryManagementViewController {
    fileprivate func rightBarButtonSetup() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(sender:)))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func save(sender: UIBarButtonItem) {
        sender.isEnabled = false
        let size = sizes[sizeRow.selectedRow]
        save(productType: productType, size: size)
    }
}
