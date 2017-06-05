//
//  CutListViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class CutListViewController: UIViewController {
    var getListButton: UIButton!
    
    var dataStore: CutListDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        showPasswordPrompt()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let cutView = CutListView(frame: self.view.bounds)
        self.view = cutView
        getListButton = cutView.getListButton
        getListButton.addTarget(self, action: #selector(getListButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = CutListDataStore(delegate: self)
    }
}

extension CutListViewController {
    func getListButtonPressed() {
        getListButton.isUserInteractionEnabled = false
        dataStore?.getCutList()
    }
}

extension CutListViewController: CutListDataDelegate {
    func recieved(error: Error) {
        getListButton.isUserInteractionEnabled = true
        SCLAlertView().showError("Error", subTitle: error.localizedDescription)
    }
    
    func recieved(success: Bool) {
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Go Home") {
            self.popVC()
        }
        alertView.showSuccess("Success", subTitle: "A new google sheet has been made with a cut list that has all cuts needed since last cut list was created")
        
    }
}

extension CutListViewController {
    fileprivate func showPasswordPrompt() {
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        let textField = alertView.addTextField()
        alertView.addButton("Enter") {
            let password = "Password"
            if textField.text == password {
                alertView.hideView()
            } else {
                self.popVC()
            }
        }
        alertView.showInfo("Enter Admin Password", subTitle: "this page will send a cut list to Andrew")
    }
}
