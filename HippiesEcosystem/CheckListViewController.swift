//
//  CheckListViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class CheckListViewController: UIViewController {
    var tableView: CheckListTableView!
    var lineItems: [LineItem] = []
    
    var rightBarButtonTitle: String {
        return "Next"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        rightBarButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewSetup() {
        tableView = PickItemTableView(frame: self.view.bounds, lineItems: lineItems)
        self.view.addSubview(tableView)
    }
    
    func rightBarButtonSetup() {
        let barButton = UIBarButtonItem(title: rightBarButtonTitle, style: .plain, target: self, action: #selector(rightBarButtonPressed))
        navigationItem.rightBarButtonItem = barButton
    }
    
    func rightBarButtonPressed() {
        if tableView.isComplete {
            //all items checked, so we can save
            proceed()
        } else {
            SCLAlertView().showError("Not All Boxes Checked", subTitle: "Not all items have been checked off")
        }
    }
    
    func proceed() {
        preconditionFailure("must override in subclass")
    }
}
