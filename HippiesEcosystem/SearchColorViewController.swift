//
//  SearchColorViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataStore = dataStore as? SearchColorDataStore, let fabric = results[indexPath.row] as? Fabric  {
            dataStore.getCutListFor(fabric: fabric)
        }
    }
}

extension SearchColorViewController: SearchColorDataDelegate {
    func successfullyCreatedCutList(for fabric: Fabric) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Home") { 
            self.popVC()
        }
        alertView.showSuccess("Success", subTitle: "Check the google sheet to see a mass cut list for color: " + fabric.color)
    }
}
