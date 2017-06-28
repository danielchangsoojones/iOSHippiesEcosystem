//
//  AggregateInventoryViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class AggregateInventoryViewController: UIViewController {
    var tableView: UITableView!
    
    var dataStore: AggregateInventoryDataStore?
    var productType: ProductType!
    var sizeGroups: [SizeGroup] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
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
        dataStoreSetup()
        rightBarButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AggregateInventoryTableViewCell.self, forCellReuseIdentifier: AggregateInventoryTableViewCell.identifier)
        self.view.addSubview(tableView)
    }
    
    private func dataStoreSetup() {
        dataStore = AggregateInventoryDataStore(delegate: self)
        dataStore?.loadInventories(from: productType)
    }
}

extension AggregateInventoryViewController {
    fileprivate func rightBarButtonSetup() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(sender:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func save(sender: UIBarButtonItem) {
        sender.isEnabled = false
    }
}

extension AggregateInventoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizeGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AggregateInventoryTableViewCell.identifier, for: indexPath) as! AggregateInventoryTableViewCell
        let sizeGroup = sizeGroups[indexPath.row]
        cell.set(size: sizeGroup.size, count: sizeGroup.items.count)
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension AggregateInventoryViewController: AggregateInventoryCellDelegate {
    func update(count: Int, at index: Int) {
        let sizeGroup = sizeGroups[index]
        sizeGroup.count = count
    }
}

extension AggregateInventoryViewController: AggregateInventoryDataDelegate {
    func received(sizeGroups: [SizeGroup]) {
        self.sizeGroups = sizeGroups
    }
    
    func received(error: Error) {
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Done") {
            self.popVC()
        }
        alertView.showError("Error", subTitle: error.localizedDescription)
    }
}
