//
//  PickOrderViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PickListOrderViewController: UIViewController {
    var tableView : UITableView!
    
//    var orders: [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PickOrderTableViewCell.self, forCellReuseIdentifier: PickOrderTableViewCell.identifier)
        self.view.addSubview(tableView)
    }
}

extension PickListOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickOrderTableViewCell.identifier, for: indexPath) as! PickOrderTableViewCell
        return cell
    }
}
