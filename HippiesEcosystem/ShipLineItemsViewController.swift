//
//  ShipLineItemsViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ShipLineItemsViewController: CheckListViewController {
    var orderID: Int!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
