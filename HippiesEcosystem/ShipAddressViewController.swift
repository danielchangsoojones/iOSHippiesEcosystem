//
//  ShipAddressViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ShipAddressViewController: OrderInformationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setContent() {
        infoTextView.text = order.address.toString()
        instructionLabel.text = "Does the shipping sticker match this address?"
    }
    
    override func yesPressed() {
        print("yes press")
    }
}
