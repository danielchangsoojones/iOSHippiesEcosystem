//
//  AnalyticsViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/30/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class AnalyticsViewController: UIViewController {
    var tableView: UITableView!
    
    var analytics: [Analytic] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AnalyticsViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.register(AnalyticTableViewCell.self, forCellReuseIdentifier: AnalyticTableViewCell.identifier)
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnalyticTableViewCell.identifier, for: indexPath) as! AnalyticTableViewCell
        let analytic = analytics[indexPath.row]
        cell.set(title: analytic.title, count: analytic.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analytics.count
    }
}

extension AnalyticsViewController: AnalyticsDataDelegate {
    func received(analytics: [Analytic]) {
        self.analytics = analytics
    }
    
    func received(error: Error) {
        SCLAlertView().showError("Error", subTitle: error.localizedDescription)
    }
}


