//
//  CutListView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CutListView: UIView {
    var getListButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        getListButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getListButtonSetup() {
        getListButton = Helpers.stylizeButton(text: "Get Cut List")
        self.addSubview(getListButton)
        getListButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
