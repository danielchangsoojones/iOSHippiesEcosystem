//
//  VersionNumber.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

class VersionNumberParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "VersionNumber"
    }
    
    @NSManaged var build: Int
    
    static func check() {
        let query = VersionNumberParse.query()! as! PFQuery<VersionNumberParse>
        query.getFirstObjectInBackground { (versionNumberParse, error) in
            if let latestBuild = versionNumberParse?.build, let currentBuildString = Bundle.main.buildVersionNumber, let currentBuild = currentBuildString.toInt() {
                if latestBuild > currentBuild {
                    showNewVersionAvailableAlert()
                } else if latestBuild < currentBuild {
                    //update the database to the newest build that we have seen a user with. This is not perfect because if no one has ever downloaded the newest version, then it would never change. But, it's the best way that Daniel Jones can figure out how to do this right now
                    versionNumberParse?.build = currentBuild
                    versionNumberParse?.saveInBackground()
                }
            } else if let _ = error {
                var appConfiguration = Configuration()
                let enviroment = appConfiguration.environment
                if enviroment == .Production {
                    showNewVersionAvailableAlert()
                }
            }
        }
    }
    
    static func showNewVersionAvailableAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Download", action: {
            segueToTestFlight()
        })
        alertView.showInfo("Need New Version", subTitle: "There is a new app version available, please go to Testflight to download the newest version")
    }
    
    static func segueToTestFlight() {
        if let customAppURL = URL(string: "itms-beta://"), UIApplication.shared.canOpenURL(customAppURL) {
            // TestFlight is installed
            let appAppleID = "1245984388"
            if let specificAppURL = URL(string: "https://beta.itunes.apple.com/v1/app/" + appAppleID) {
                UIApplication.shared.openURL(specificAppURL)
            }
        }
    }
}

extension Bundle {
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
