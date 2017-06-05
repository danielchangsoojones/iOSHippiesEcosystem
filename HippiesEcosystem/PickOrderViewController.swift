//
//  PickOrderViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PickListOrderViewController: UIViewController {
    var tableView : UITableView!
    var theSpinner: UIActivityIndicatorView!
    
    var orders: [Order] = []
    var lineItemDictionary: [Order : [LineItem]] = [:]
    
    var dataStore: PickOrderDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        spinnerSetup()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PickOrderTableViewCell.self, forCellReuseIdentifier: PickOrderTableViewCell.identifier)
        self.view.addSubview(tableView)
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = PickOrderDataStore(delegate: self)
        dataStore?.getPickList()
    }
    
    fileprivate func spinnerSetup() {
        theSpinner = UIActivityIndicatorView()
        self.view.addSubview(theSpinner)
        theSpinner.startAnimating()
    }
}

extension PickListOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickOrderTableViewCell.identifier, for: indexPath) as! PickOrderTableViewCell
        let order = orders[indexPath.row]
        cell.set(order: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        if let lineItems = lineItemDictionary[order] {
            segueToLineItemPickVC(lineItems: lineItems, order: order)
        }
    }
    
    func segueToLineItemPickVC(lineItems: [LineItem], order: Order) {
        let itemPickVC = PickListItemViewController()
        if let lineItems = lineItemDictionary[order] {
            itemPickVC.lineItems = lineItems
            itemPickVC.title = order.name
            pushVC(itemPickVC)
        }
    }
    
    func removeRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            orders.remove(at: selectedIndexPath.row)
            tableView.deleteRows(at: [selectedIndexPath], with: .automatic)
        }
    }
}

extension PickListOrderViewController: PickOrderDataStoreDelegate {
    func recieved(orders: [Order], orderDictionary: [Order : [LineItem]]) {
        self.orders = orders
        self.lineItemDictionary = orderDictionary
        tableView.reloadData()
        theSpinner.stopAnimating()
    }
    
    func recieved(error: Error) {
        theSpinner.stopAnimating()
    }
}
