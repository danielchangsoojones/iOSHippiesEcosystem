//
//  PickItemTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BEMCheckBox

class PickItemTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return PickItemTableViewCell.identifier
    }
    
    var idLabel: UILabel!
    var checkBox: BEMCheckBox!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        idLabelSetup()
        checkBoxSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func idLabelSetup() {
        idLabel = UILabel()
        idLabel.text = "9123244543"
        self.addSubview(idLabel)
        idLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func checkBoxSetup() {
        checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, w: 35, h: 35))
        checkBox.boxType = .square
        self.addSubview(checkBox)
        checkBox.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
}

extension PickItemTableViewCell {
    static let identifier = "pickItemTableCell"
}
