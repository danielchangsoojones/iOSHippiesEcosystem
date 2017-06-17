//
//  FinishShipView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FinishShipView: UIView {
    var finishLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        finishLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func finishLabelSetup() {
        finishLabel = UILabel()
        finishLabel.text = "Please seal the shipping bag and place into the shipping bin, so the item can be sent out into the mail"
        finishLabel.font = UIFont.systemFont(ofSize: 30)
        finishLabel.numberOfLines = 0
        self.addSubview(finishLabel)
        finishLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }

}
