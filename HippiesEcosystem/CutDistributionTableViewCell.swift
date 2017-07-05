//
//  CutDistributionTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 7/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CutDistributionTableViewCell: AnalyticTableViewCell {
    override var reuseIdentifier: String? {
        return CutDistributionTableViewCell.cellIdentifier
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.textColor = Constants.countColor
    }
    
    func set(color: String, count: Int) {
        titleLabel.text = color
        numberLabel.text = count.toString
    }
}

extension CutDistributionTableViewCell {
    static let cellIdentifier = "cutDistributionTableCell"
}
