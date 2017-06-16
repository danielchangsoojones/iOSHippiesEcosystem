//
//  PickItemTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BEMCheckBox

class PickItemTableViewCell: CheckTableViewCell {
    override var reuseIdentifier: String? {
        return PickItemTableViewCell.cellIdentifier
    }
    
    var idLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        idLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func set(lineItem: LineItem) {
        super.set(lineItem: lineItem)
        idLabel.text = "Item ID: " + lineItem.shopifyID
    }
    
    fileprivate func idLabelSetup() {
        idLabel = UILabel()
        stackView.addArrangedSubview(idLabel)
    }
}

extension PickItemTableViewCell {
    static let cellIdentifier = "pickItemTableCell"
}
