//
//  ShipLineItemsViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ShipLineItemsViewController: UIViewController {
    var tableView: UITableView!
    
    var orderID: Int!
    var lineItems: [LineItem] = []
    
    init(orderID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.orderID = orderID
        self.title = orderID.toString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShipLineItemsViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(CheckTableViewCell.self, forCellReuseIdentifier: CheckTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckTableViewCell.identifier, for: indexPath) as! CheckTableViewCell
        return cell
    }
}
