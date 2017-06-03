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
    
    var orders: [Order] = []
    var lineItemDictionary: [Order : [LineItem]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
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
}

extension PickListOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        //TODO: send over the line items for that order
        itemPickVC.title = order.name
        pushVC(itemPickVC)
    }
    
    func removeRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            orders.remove(at: selectedIndexPath.row)
            tableView.deleteRows(at: [selectedIndexPath], with: .automatic)
        }
    }
}
