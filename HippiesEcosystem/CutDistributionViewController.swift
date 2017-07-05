//
//  CutDistributionViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 7/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class CutDistributionViewController: UIViewController {
    var tableView: UITableView!
    
    var distributions: [CutDistribution] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    var dataStore: CutDistributionDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func dataStoreSetup() {
        dataStore = CutDistributionDataStore(delegate: self)
        dataStore?.loadDistributions()
    }
}

extension CutDistributionViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CutDistributionTableViewCell.self, forCellReuseIdentifier: CutDistributionTableViewCell.cellIdentifier)
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distributions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CutDistributionTableViewCell.cellIdentifier, for: indexPath) as! CutDistributionTableViewCell
        let cutDistribution = distributions[indexPath.row]
        if cutDistribution.count > 100 {
            cell.numberLabel.textColor = .red
        }
        cell.set(color: cutDistribution.color, count: cutDistribution.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertView = SCLAlertView()
        alertView.addButton("Yes", action: {
            let cutDistribution = self.distributions[indexPath.row]
            self.dataStore?.createCutList(from: cutDistribution)
            alertView.dismissVC(completion: nil)
        })
        alertView.showInfo("Cut List", subTitle: "Create a Google Sheet Cut List")
    }
}

extension CutDistributionViewController: CutDistributionDataDelegate {
    func received(distributions: [CutDistribution]) {
        self.distributions = distributions
    }
    
    func received(error: Error) {
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Home") {
            self.popVC()
        }
        alertView.showError("Error", subTitle: error.localizedDescription)
    }
}
