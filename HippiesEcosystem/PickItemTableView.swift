//
//  PickItemTableView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PickItemTableView: CheckListTableView {
    override init(frame: CGRect, lineItems: [LineItem]) {
        super.init(frame: frame, lineItems: lineItems)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dequeueCell(indexPath: IndexPath) -> CheckTableViewCell {
        return dequeueReusableCell(withIdentifier: PickItemTableViewCell.cellIdentifier, for: indexPath) as! PickItemTableViewCell
    }
    
    override func registerCell() {
        register(PickItemTableViewCell.self, forCellReuseIdentifier: PickItemTableViewCell.cellIdentifier)
    }
}
