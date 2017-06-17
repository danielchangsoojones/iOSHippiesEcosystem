//
//  CheckTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BEMCheckBox

class CheckTableViewCell: UITableViewCell {
    struct Constants {
        static let cellHeight: CGFloat = 100
    }
    
    override var reuseIdentifier: String? {
        return CheckTableViewCell.identifier
    }
    
    var checkBox: BEMCheckBox!
    var stackView: UIStackView!
    var itemTitleLabel: UILabel!
    var sizeLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        checkBoxSetup()
        stackViewSetup()
        itemTitleLabelSetup()
        sizeLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(lineItem: LineItem) {
        itemTitleLabel.text = lineItem.title
        sizeLabel.text = lineItem.size
    }
    
    fileprivate func checkBoxSetup() {
        let side = Constants.cellHeight / 2
        checkBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, w: side, h: side))
        checkBox.boxType = .square
        self.addSubview(checkBox)
        checkBox.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func stackViewSetup() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(checkBox.snp.leading)
        }
    }
    
    fileprivate func itemTitleLabelSetup() {
        itemTitleLabel = UILabel()
        stackView.addArrangedSubview(itemTitleLabel)
    }
    
    fileprivate func sizeLabelSetup() {
        sizeLabel = UILabel()
        stackView.addArrangedSubview(sizeLabel)
    }
}

extension CheckTableViewCell {
    static let identifier = "checkTableViewCell"
}
