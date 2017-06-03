//
//  Helpers.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

struct Helpers {
    static var line: UIView {
        let line = UIView(frame: CGRect(x: 0, y: 0, w: 0, h: 1))
        line.backgroundColor = CustomColors.SilverChalice
        line.alpha = 0.5
        return line
    }
    
    static func stylizeButton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = CustomColors.Polar
        button.setTitle(text, for: .normal)
        button.titleLabel!.font =  UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        button.setTitleColor(CustomColors.SilverChalice, for: .normal)
        let horizontalInset: CGFloat = 30
        let verticalInset: CGFloat = 10
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        button.setCornerRadius(radius: 15)
        return button
    }
}
