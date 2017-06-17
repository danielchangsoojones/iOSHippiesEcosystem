//
//  OrderNoteViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class OrderNoteViewController: OrderInformationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func yesPressed() {
        let shippingAddressVC = ShipAddressViewController(order: order)
        pushVC(shippingAddressVC)
    }
    
    fileprivate func setContent() {
        infoTextView.text = order.note
        instructionLabel.text = "Does the order conform to its note?"
    }
}
