//
//  ShipLineItemsViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class ShipLineItemsViewController: CheckListViewController {
    var orderID: Int!
    var spinnerView: UIView?
    var order: Order?
    
    init(orderID: Int) {
        super.init(nibName: nil, bundle: nil)
        self.orderID = orderID
        self.title = order?.name
    }
    
    var dataStore: ShipLineItemsDataStore?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = Helpers.showActivityIndicatory(on: self.view)
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = ShipLineItemsDataStore(delegate: self)
        dataStore?.loadLineItems(orderID: orderID)
    }
    
    override func proceed() {
        if let order = order {
            if let note = order.note, !note.isBlank {
                segueToOrderNoteVC(order: order)
            } else {
                segueToAddressVC(order: order)
            }
        }
    }
}

extension ShipLineItemsViewController: ShipLineItemsDataDelegate {
    func recieved(order: Order?) {
        if let order = order {
            spinnerView?.removeFromSuperview()
            self.order = order
            self.lineItems = order.lineItems
        } else {
            showErrorAlert(title: "Invalid Order ID", subTitle: "There was no order ID found. Please try re-typing the order number")
        }
    }
    
    func showErrorAlert(title: String, subTitle: String) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Okay") { 
            self.popVC()
        }
        alertView.showError(title, subTitle: subTitle)
    }
    
    func recieved(error: Error) {
        showErrorAlert(title: "Error", subTitle: error.localizedDescription)
    }
}

//segues
extension ShipLineItemsViewController {
    func segueToOrderNoteVC(order: Order) {
        let orderNoteVC = OrderNoteViewController(order: order)
        pushVC(orderNoteVC)
    }
    
    func segueToAddressVC(order: Order) {
        let shipAddressVC = ShipAddressViewController(order: order)
        pushVC(shipAddressVC)
    }
}
