//
//  HomeViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    fileprivate struct Categories {
        static let inputInventory = "Input Inventory"
        static let pickTickets = "Pick Tickets"
    }
    
    var theTableView: UITableView!
    let categories: [String] = [Categories.inputInventory, Categories.pickTickets]

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
        cell.textLabel?.text = category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        switch category {
        case Categories.inputInventory:
            segueToProductSeachVC()
        case Categories.pickTickets:
            break
        default:
            break
        }
    }
}

extension HomeViewController {
    func segueToProductSeachVC() {
        let searchVC = ProductSearchViewController()
        pushVC(searchVC)
    }
}
