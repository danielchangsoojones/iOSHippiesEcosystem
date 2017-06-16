//
//  ShipViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ShipOrderViewController: UIViewController {
    var orderIDTextField: UITextField!
    var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        nextButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let shipView = ShipOrderView(frame: self.view.bounds)
        self.view = shipView
        self.orderIDTextField = shipView.orderIDTextField
        orderIDTextField.delegate = self
    }
}

extension ShipOrderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        let maxCharactersAllowed = 4
        nextButton.isEnabled = newLength >= maxCharactersAllowed
        return newLength <= maxCharactersAllowed
    }
}

//next extension
extension ShipOrderViewController {
    fileprivate func nextButtonSetup() {
        nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
        nextButton.isEnabled = false
        navigationItem.rightBarButtonItem = nextButton
    }
    
    func nextButtonPressed() {
        let orderID: Int = orderIDTextField.text?.toInt() ?? 0
        let shipLineItemsVC = ShipLineItemsViewController(orderID: orderID)
        pushVC(shipLineItemsVC)
    }
}
