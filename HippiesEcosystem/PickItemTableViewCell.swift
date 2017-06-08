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
    
    var stackView: UIStackView!
    var idLabel: UILabel!
    var itemTitleLabel: UILabel!
    var sizeLabel: UILabel!
    var checkBox: BEMCheckBox!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        checkBoxSetup()
        stackViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(lineItem: LineItem) {
        itemTitleLabel.text = lineItem.title
        idLabel.text = "Item ID: " + lineItem.shopifyID
        sizeLabel.text = lineItem.size
    }
    
    fileprivate func checkBoxSetup() {
        let side = PickListItemViewController.Constants.cellHeight / 2
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
        itemTitleLabelSetup()
        sizeLabelSetup()
        idLabelSetup()
    }
    
    fileprivate func itemTitleLabelSetup() {
        itemTitleLabel = UILabel()
        stackView.addArrangedSubview(itemTitleLabel)
    }
    
    fileprivate func sizeLabelSetup() {
        sizeLabel = UILabel()
        stackView.addArrangedSubview(sizeLabel)
    }
    
    fileprivate func idLabelSetup() {
        idLabel = UILabel()
        stackView.addArrangedSubview(idLabel)
    }
}

extension PickItemTableViewCell {
    static let identifier = "pickItemTableCell"
}
