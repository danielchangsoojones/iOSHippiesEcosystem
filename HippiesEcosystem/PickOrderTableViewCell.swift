//
//  PickOrderTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PickOrderTableViewCell: UITableViewCell {
    var idLabel: UILabel!
    
    override var reuseIdentifier: String? {
        return PickOrderTableViewCell.identifier
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        idLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func idLabelSetup() {
        idLabel = UILabel()
        idLabel.text = "#HippiesandHousewives2806<3"
        self.addSubview(idLabel)
        idLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }

}

extension PickOrderTableViewCell {
    static let identifier = "pickOrderTableCell"
}
