//
//  OrderInformationViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class OrderInformationView: UIView {
    var instructionLabel: UILabel!
    var informationTextView: UITextView!
    var yesButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        instructionLabelSetup()
        informationTextViewSetup()
        yesButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func instructionLabelSetup() {
        instructionLabel = UILabel()
        instructionLabel.text = "Does the order conform to its note?"
        instructionLabel.numberOfLines = 0
        instructionLabel.font = UIFont.systemFont(ofSize: 30)
        instructionLabel.textAlignment = .center
        self.addSubview(instructionLabel)
        instructionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(self.frame.height * 0.1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func informationTextViewSetup() {
        informationTextView = UITextView()
        informationTextView.font = UIFont.systemFont(ofSize: 20)
        informationTextView.addBorder(width: 1, color: .black)
        informationTextView.isEditable = false
        self.addSubview(informationTextView)
        informationTextView.snp.makeConstraints { (make) in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(instructionLabel)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    fileprivate func yesButtonSetup() {
        yesButton = createActionButton(title: "YES", color: CustomColors.JellyTeal)
        self.addSubview(yesButton)
        yesButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(informationTextView.snp.bottom).offset(10)
        }
    }
    
    fileprivate func createActionButton(title: String, color: UIColor) -> UIButton {
        let button = Helpers.stylizeButton(text: title)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        return button
    }
}
