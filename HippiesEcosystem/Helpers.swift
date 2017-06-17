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
    
    static func enterApplication(from presentingVC: UIViewController) {
        let homeViewController = HomeViewController()
        let navController = UINavigationController(rootViewController: homeViewController)
        presentingVC.presentVC(navController)
    }
    
    static func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            return keyboardHeight
        }
        return 0
    }
    
    static func showActivityIndicatory(uiView: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0.0, y: 0.0, w: 80.0, h: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(r: 0.25, g: 0.25, b: 0.25, a: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, w: 40.0, h: 40.0)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return container
    }
}
