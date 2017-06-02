//
//  MainSearchingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ProductSearchViewController: UIViewController {
    var theSearchBar: CustomSearchBar!
    var theTableView: UITableView!
    var theSpinnerView: UIView?
    
    var results: [ProductType] = [] {
        didSet {
            hasLoadedDatabaseOnce = true
        }
    }
    var hasLoadedDatabaseOnce: Bool = false
    
    var dataStore: MainSearchingDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataStoreSetup()
    }
    
    fileprivate func viewSetup() {
        let searchingView = MainSearchingView(frame: self.view.bounds, navBarHeight: navigationBarHeight + ez.screenStatusBarHeight)
        self.view = searchingView
        theTableView = searchingView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theSearchBar = searchingView.theSearchBar
        theSearchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func dataStoreSetup() {
        dataStore = MainSearchingDataStore(delegate: self)
    }
}

extension ProductSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if results.isEmpty && hasLoadedDatabaseOnce {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No results found"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
        } else {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        return numOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productType = results[indexPath.row]
        let cell = MainSearchTableViewCell(title: productType.title)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productType = results[indexPath.row]
        segueToInputInventoryVC(product: productType)
    }
    
    func segueToInputInventoryVC(product: ProductType) {
        let inputInventoryVC = InputInventoryViewController()
        inputInventoryVC.title = product.title
        pushVC(inputInventoryVC)
    }
}

extension ProductSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataStore?.search(text: searchText)
    }
}

extension ProductSearchViewController: MainSearchingDelegate {
    func passSearchResults(results: [ProductType]) {
        self.results = results
        theTableView.reloadData()
    }
    
    func getMostCurrentSearchText() -> String? {
        return theSearchBar.text
    }
}
