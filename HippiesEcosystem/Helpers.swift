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
}
