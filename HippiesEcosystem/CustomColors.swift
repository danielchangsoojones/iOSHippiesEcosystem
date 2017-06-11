//
//  CustomColors.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions


struct CustomColors {
    static let AquamarineBlue: UIColor = UIColor(r: 108, g: 223, b: 214)
    static let GrannySmithGreen: UIColor = UIColor(r: 165, g: 223, b: 160)
    static let SilverChalice: UIColor = UIColor(r: 178, g: 178, b: 178)
    static let Polar: UIColor = UIColor(r: 204, g: 243, b: 237)
    static let JellyTeal: UIColor = UIColor(r: 1, g: 195, b: 167)
    static let welcomeGradientColors: [CGColor] = [CustomColors.JellyTeal.cgColor, CustomColors.Polar.cgColor]
    
    static func addGradient(colors: [CGColor], to view: UIView, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = view.frame.size
        gradient.colors = colors
        if let startPoint = startPoint {
            gradient.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradient.endPoint = endPoint
        }
        view.layer.insertSublayer(gradient, at: 0)
    }
}
