//
//  AggregateInventoryTableViewCell.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

protocol AggregateInventoryCellDelegate {
    func update(count: Int)
}

class AggregateInventoryTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return AggregateInventoryTableViewCell.identifier
    }
    
    var sizeLabel: UILabel!
    var countTextField: UITextField!
    var buttonStackView: UIStackView!
    
    var count: Int = 0 {
        didSet {
            if count >= 0 && count != oldValue {
                delegate?.update(count: count)
                countTextField.text = count.toString
            }
        }
    }
    var delegate: AggregateInventoryCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sizeLabelSetup()
        buttonStackViewSetup()
        countTextFieldSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(size: String, count: Int) {
        sizeLabel.text = size
        self.count = count
    }
}

extension AggregateInventoryTableViewCell {
    fileprivate func sizeLabelSetup() {
        sizeLabel = UILabel()
        sizeLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        self.addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

extension AggregateInventoryTableViewCell {
    fileprivate func buttonStackViewSetup() {
        let plusButton = createButton(type: .plus, selector: #selector(plusButtonPressed))
        let minusButton = createButton(type: .minus, selector: #selector(minusButtonPressed))
        buttonStackView = UIStackView(arrangedSubviews: [plusButton, minusButton])
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 15
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.width.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    enum ButtonType {
        case plus
        case minus
    }
    
    fileprivate func createButton(type: ButtonType, selector: Selector) -> UIButton {
        var image: UIImage!
        
        switch type {
        case .plus:
            image = #imageLiteral(resourceName: "plus")
        case .minus:
            image = #imageLiteral(resourceName: "minus")
        }
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.target(forAction: selector, withSender: button)
        return button
    }
    
    func plusButtonPressed(sender: UIButton) {
        count += 1
    }
    
    func minusButtonPressed() {
        count -= 1
    }
}

extension AggregateInventoryTableViewCell {
    fileprivate func countTextFieldSetup() {
        countTextField = UITextField()
        countTextField.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        countTextField.keyboardType = .numberPad
        countTextField.borderStyle = .line
        countTextField.addTarget(self, action: #selector(textChanged(textField:)), for: .editingChanged)
        self.addSubview(countTextField)
        countTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-15)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func textChanged(textField: UITextField) {
        if let newCount = textField.text?.toInt() {
            print(newCount)
            count = newCount
        }
    }
}

extension AggregateInventoryTableViewCell {
    static let identifier = "aggregateInventoryTableCell"
}
