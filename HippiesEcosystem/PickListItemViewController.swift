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

class PickListItemViewController: UIViewController {
    struct Constants {
        static let cellHeight: CGFloat = 100
    }
    
    var tableView : UITableView!
    
    var lineItems: [LineItem] = []
    var completes: [Bool] = []
    
    var dataStore: PickItemDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        dataStoreSetup()
        titleSetup()
        populateCompletes()
        rightBarButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PickItemTableViewCell.self, forCellReuseIdentifier: PickItemTableViewCell.identifier)
        self.view.addSubview(tableView)
    }
    
    func populateCompletes() {
        for _ in lineItems {
            completes.append(false)
        }
    }
    
    fileprivate func rightBarButtonSetup() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = barButton
    }
    
    fileprivate func titleSetup() {
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = PickItemDataStore(delegate: self)
    }
    
    func save() {
        if !completes.contains(false) {
            //all items checked, so we can save
            self.dataStore?.save(lineItems: lineItems)
        } else {
            SCLAlertView().showError("Not All Boxes Checked", subTitle: "Not all items have been checked off")
        }
    }
}

extension PickListItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickItemTableViewCell.identifier, for: indexPath) as! PickItemTableViewCell
        cell.checkBox.tag = indexPath.row
        cell.checkBox.delegate = self
        let lineItem = lineItems[indexPath.row]
        cell.set(lineItem: lineItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}

extension PickListItemViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        let checkedRow = checkBox.tag
        completes[checkedRow] = checkBox.on
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
