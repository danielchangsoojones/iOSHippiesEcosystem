//
//  ShipOrderView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ShipOrderView: UIView {
    var enterOrderLabel: UILabel!
    var orderIDTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        enterOrderLabelSetup()
        orderIDTextFieldSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func enterOrderLabelSetup() {
        enterOrderLabel = UILabel()
        enterOrderLabel.text = "Enter Order ID:"
        enterOrderLabel.textAlignment = .center
        enterOrderLabel.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(enterOrderLabel)
        enterOrderLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(self.frame.height * 0.2)
        }
    }
    
    fileprivate func orderIDTextFieldSetup() {
        orderIDTextField = UITextField()
        orderIDTextField.borderStyle = .line
        orderIDTextField.placeholder = "i.e. 3245"
        orderIDTextField.font = UIFont.systemFont(ofSize: 30)
        orderIDTextField.keyboardType = .numberPad
        self.addSubview(orderIDTextField)
        orderIDTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(enterOrderLabel.snp.bottom).offset(10)
        }
    }

}
