//
//  HomeViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    fileprivate enum Categories: String {
        case inputInventory = "Input Inventory"
        case pickTickets = "Pick Tickets"
        case cutting = "Cutting"
        case sewing = "Sewn"
        case packaging = "Packaging"
        case shipped = "Shipped"
        
        static let all : [Categories] = [.inputInventory, .cutting, .sewing, .packaging, .pickTickets, .shipped]
    }
    
    var theTableView: UITableView!
    fileprivate let categories: [Categories] = Categories.all

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createTableView() {
        theTableView = UITableView(frame: self.view.bounds)
        self.view.addSubview(theTableView)
        theTableView.delegate = self
        theTableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: I should be reusing cells, but who cares for now.
        let category = categories[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = category.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        var targetVC: UIViewController!
        switch category {
        case .inputInventory:
            targetVC = ProductSearchViewController()
        case .cutting:
            targetVC = CuttingFormViewController()
        case .sewing:
            targetVC = SewingFormViewController()
        case .packaging:
            targetVC = PackageFormViewController()
        case .pickTickets:
            targetVC = UIViewController()
        case .shipped:
            targetVC = QualityFormViewController()
        }
        
        pushWithTitle(vc: targetVC)
    }
}

extension HomeViewController {
    func pushWithTitle(vc: UIViewController) {
        if let selectedIndexPath = theTableView.indexPathForSelectedRow {
            let category = categories[selectedIndexPath.row]
            vc.title = category.rawValue
        }
        
        pushVC(vc)
    }
}
