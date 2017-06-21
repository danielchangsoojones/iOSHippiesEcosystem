//
//  SearchColorViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class SearchColorViewController: MainSearchingViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dataStoreSetup() {
        dataStore = SearchColorDataStore(delegate: self)
    }
    
    override func createCell(indexPath: IndexPath) -> MainSearchTableViewCell {
        let fabric = results[indexPath.row] as! Fabric
        let cell = MainSearchTableViewCell(title: fabric.color)
        return cell
    }
}
