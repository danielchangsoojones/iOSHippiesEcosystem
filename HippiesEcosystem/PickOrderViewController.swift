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
    
    var pickables: [Pickable] = []
    
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
        return pickables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickOrderTableViewCell.identifier, for: indexPath) as! PickOrderTableViewCell
        let order = pickables[indexPath.row].order
        cell.set(order: order)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pickable = pickables[indexPath.row]
        segueToLineItemPickVC(pickable: pickable)
    }
    
    func segueToLineItemPickVC(pickable: Pickable) {
        let itemPickVC = PickListItemViewController()
        itemPickVC.pickable = pickable
        itemPickVC.title = pickable.order.name
        pushVC(itemPickVC)
    }
    
    func removeRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            pickables.remove(at: selectedIndexPath.row)
            tableView.deleteRows(at: [selectedIndexPath], with: .automatic)
        }
    }
}

extension PickListOrderViewController: PickOrderDataStoreDelegate {
    func recieved(_ pickables: [Pickable]) {
        self.pickables = pickables
        tableView.reloadData()
        theSpinner.stopAnimating()
    }
    
    func recieved(error: Error) {
        theSpinner.stopAnimating()
    }
}
