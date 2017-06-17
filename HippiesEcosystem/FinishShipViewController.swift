//
//  FinishShipViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class FinishShipViewController: UIViewController {
    var order: Order!
    var dataStore: FinishShipDataStore?
    
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
        self.title = order.shortName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataStoreSetup()
        finishButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let finishShipView = FinishShipView(frame: self.view.frame)
        self.view = finishShipView
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = FinishShipDataStore(delegate: self)
    }
}

extension FinishShipViewController {
    fileprivate func finishButtonSetup() {
        let finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finish(button:)))
        navigationItem.rightBarButtonItem = finishButton
    }
    
    func finish(button: UIBarButtonItem) {
        button.isEnabled = false
        dataStore?.ship(order: order)
    }
}

extension FinishShipViewController: FinishShipDataDelegate {
    func shipped(order: Order) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Done", action: {
            self.popToEnterOrderIdVC()
        })
        alertView.showSuccess(order.shortName, subTitle: "Successfully recorded shipment")
    }
    
    fileprivate func popToEnterOrderIdVC() {
        if let navController = self.navigationController {
            let viewControllers: [UIViewController] = navController.viewControllers
            for aViewController in viewControllers {
                if let shipOrderViewController = aViewController as? ShipOrderViewController {
                    shipOrderViewController.orderIDTextField.text = ""
                    navController.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    func received(error: Error) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        SCLAlertView().showError("Error", subTitle: error.localizedDescription)
    }
}
