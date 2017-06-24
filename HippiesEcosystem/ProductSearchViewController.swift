//
//  MainSearchingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ProductSearchViewController: MainSearchingViewController {
    enum ResulAction {
        case remove
        case input
        case multipleCut
        case aggregateInventory
    }
    
    var resultAction: ResulAction = .input
    
    init(resultAction: ResulAction) {
        super.init(nibName: nil, bundle: nil)
        self.resultAction = resultAction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func createCell(indexPath: IndexPath) -> MainSearchTableViewCell {
        let productType = results[indexPath.row] as! ProductType
        let cell = MainSearchTableViewCell(title: productType.title)
        return cell
    }
    
    override func dataStoreSetup() {
        dataStore = ProductSearchDataStore(delegate: self)
    }
}

extension ProductSearchViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productType = results[indexPath.row] as! ProductType
        segueToInventoryVC(product: productType)
    }
    
    func segueToInventoryVC(product: ProductType) {
        var targetVC: InventoryManagementViewController!
        
        switch resultAction {
        case .input:
            targetVC = InputInventoryViewController(productType: product)
        case .remove:
            targetVC = RemoveInventoryViewController(productType: product)
        case .multipleCut:
            targetVC = MultipleCutsViewController(productType: product)
        case .aggregateInventory:
            targetVC = 
        }
        
        targetVC.title = product.title
        pushVC(targetVC)
    }
}
