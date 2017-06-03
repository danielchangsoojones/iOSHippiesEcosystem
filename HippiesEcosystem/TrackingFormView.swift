//
//  TrackingFormView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SnapKit

class TrackingFormView: UIView {
    var idTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        idTextFieldSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func idTextFieldSetup() {
        idTextField = UITextField()
        idTextField.placeholder = "Enter ID Number"
        idTextField.borderStyle = .line
        idTextField.keyboardType = .numberPad
        idTextField.clearButtonMode = .always
        self.addSubview(idTextField)
        idTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(self.frame.height * 0.25)
            make.leading.trailing.equalToSuperview().inset(self.frame.width * 0.1)
            make.height.equalTo(100)
        }
    }

}
