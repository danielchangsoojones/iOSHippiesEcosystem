//
//  MainSearchingViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class MainSearchingViewController: UIViewController {
    var theSearchBar: CustomSearchBar!
    var theTableView: UITableView!
    var theSpinnerView: UIView?
    
    var results: [Any] = [] {
        didSet {
            hasLoadedDatabaseOnce = true
        }
    }
    var dataStore: MainSearchingDataStore?
    
    var hasLoadedDatabaseOnce: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataStoreSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func createCell(indexPath: IndexPath) -> MainSearchTableViewCell {
        fatalError("must override in subclasses")
    }
    
    func dataStoreSetup() {
        fatalError("must override in subclasses")
    }
}

extension MainSearchingViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = createCell(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension MainSearchingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataStore?.search(text: searchText)
    }
}

extension MainSearchingViewController: MainSearchingDelegate {
    func passSearchResults(results: [Any]) {
        self.results = results
        theTableView.reloadData()
    }
    
    func getMostCurrentSearchText() -> String? {
        return theSearchBar.text
    }
}
