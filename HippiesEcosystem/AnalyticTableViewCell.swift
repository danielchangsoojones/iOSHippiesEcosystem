//
//  AnalyticTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class AnalyticTableViewCell: UITableViewCell {
    struct Constants {
        static let countColor: UIColor = .green
    }
    override var reuseIdentifier: String? {
        return AnalyticTableViewCell.identifier
    }
    
    var titleLabel: UILabel!
    var numberLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabelSetup()
        numberLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: AnalyticTitle, count: Int) {
        titleLabel.text = title.rawValue + ":"
        numberLabel.text = count.toString
    }
    
    fileprivate func titleLabelSetup() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func numberLabelSetup() {
        numberLabel = UILabel()
        self.addSubview(numberLabel)
        numberLabel.font = UIFont.systemFont(ofSize: 20)
        numberLabel.textColor = Constants.countColor
        numberLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
}

extension AnalyticTableViewCell {
    static let identifier = "analyticTableCell"
}
