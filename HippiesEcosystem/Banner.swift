//
//  Banner.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import BRYXBanner

struct BannerHelper {
    enum BannerType {
        case error
        case success
    }
    
    static func showBanner(title: String, subtitle: String, bannerType: BannerType = .error, duration: TimeInterval = 10) {
        var backgroundColor: UIColor = UIColor.red
        switch bannerType {
        case .error:
            backgroundColor = UIColor.red
        case .success:
            backgroundColor = UIColor.green
        }
        
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: backgroundColor)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
    }
}
