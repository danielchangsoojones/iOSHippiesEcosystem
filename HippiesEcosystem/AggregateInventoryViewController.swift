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
    var spinnerView: UIView?
    
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
        setKeyboardNotifications()
        tableViewSetup()
        dataStoreSetup()
        rightBarButtonSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //For our keyboard notifications to not be when this view disappears
        NotificationCenter.default.removeObserver(self)
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
        spinnerView = Helpers.showActivityIndicatory(on: self.view)
        dataStore?.saveUpdatedCounts(from: sizeGroups)
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
        navigationItem.rightBarButtonItem?.isEnabled = true
        spinnerView?.removeFromSuperview()
        SCLAlertView().showError("Error", subTitle: error.localizedDescription)
    }
    
    func successfullySaved() {
        popVC()
    }
}

//MARK: keyboard
extension AggregateInventoryViewController {
    fileprivate func setKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification){
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        tableView.contentInset.bottom = keyboardHeight
    }
    
    func keyboardWillHide(_ notification: NSNotification){
        tableView.contentInset.bottom = 0
    }
}
