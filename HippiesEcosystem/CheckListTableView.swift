//
//  CheckListTableView.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BEMCheckBox

class CheckListTableView: UITableView {
    fileprivate var completes: [Bool] = []
    var lineItems: [LineItem] = []
    
    var isComplete: Bool {
        return completes.contains(false)
    }
    
    init(frame: CGRect, lineItems: [LineItem]) {
        super.init(frame: frame, style: .plain)
        rowHeight = CheckTableViewCell.Constants.cellHeight
        registerCell()
        self.lineItems = lineItems
        setCompletes()
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCompletes() {
        //TODO: if we ever had multiple sections, then the completes would only be available for the first section
        for _ in 0..<numberOfRows(inSection: 0) {
            completes.append(false)
        }
    }
    
    func registerCell() {
        register(CheckTableViewCell.self, forCellReuseIdentifier: CheckTableViewCell.identifier)
    }
}

extension CheckListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(indexPath: indexPath)
        cell.checkBox.tag = indexPath.row
        cell.checkBox.delegate = self
        let lineItem = lineItems[indexPath.row]
        cell.set(lineItem: lineItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CheckTableViewCell.Constants.cellHeight
    }
    
    func dequeueCell(indexPath: IndexPath) -> CheckTableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CheckTableViewCell.identifier, for: indexPath) as! CheckTableViewCell
        return cell
    }
}

extension CheckListTableView: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        let checkedRow = checkBox.tag
        completes[checkedRow] = checkBox.on
    }
}
