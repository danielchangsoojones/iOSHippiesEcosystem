//
//  OrderNoteView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class OrderNoteView: UIView {
    var descriptionLabel: UILabel!
    var noteTextView: UITextView!
    var yesButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        descriptionLabelSetup()
        noteTextViewSetup()
        yesButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func descriptionLabelSetup() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Does the order conform to its note?"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 30)
        descriptionLabel.textAlignment = .center
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(self.frame.height * 0.1)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func noteTextViewSetup() {
        noteTextView = UITextView()
        noteTextView.font = UIFont.systemFont(ofSize: 20)
        noteTextView.addBorder(width: 1, color: .black)
        noteTextView.isEditable = false
        self.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(descriptionLabel)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    fileprivate func yesButtonSetup() {
        yesButton = createActionButton(title: "YES", color: CustomColors.JellyTeal)
        self.addSubview(yesButton)
        yesButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(noteTextView.snp.bottom).offset(10)
        }
    }
    
    fileprivate func createActionButton(title: String, color: UIColor) -> UIButton {
        let button = Helpers.stylizeButton(text: title)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        return button
    }

}
