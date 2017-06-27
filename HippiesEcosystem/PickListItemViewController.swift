//
//  PickListItemViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BEMCheckBox
import SCLAlertView

class PickListItemViewController: CheckListViewController {
    var pickable: Pickable! {
        didSet {
            self.lineItems = pickable.lineItems
        }
    }
    
    var dataStore: PickItemDataStore?
    
    override var rightBarButtonTitle: String {
        return "Save"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
        titleSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableViewSetup() {
        tableView = PickItemTableView(frame: self.view.bounds)
        tableView.lineItems = lineItems
        self.view.addSubview(tableView)
    }
    
    override func proceed() {
        self.dataStore?.pick(pickable: pickable)
    }
    
    fileprivate func titleSetup() {
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = PickItemDataStore(delegate: self)
    }
}

extension PickListItemViewController: PickItemDataStoreDelegate {
    func successfulSave() {
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Done") {
            self.removeOrderFromList()
        }
        alertView.showSuccess("Success", subTitle: "Successfully picked items")
    }
    
    func removeOrderFromList() {
        if let viewControllers = navigationController?.viewControllers, let pickOrderVC = viewControllers[viewControllers.count - 2] as? PickListOrderViewController {
            pickOrderVC.removeRow()
            popVC()
        }
    }
}
