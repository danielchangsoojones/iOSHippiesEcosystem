//
//  OrderInformationViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class OrderInformationViewController: UIViewController {
    var infoTextView: UITextView!
    var instructionLabel: UILabel!
    
    var order: Order!
    
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
        self.title = order.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func yesPressed() {
        fatalError("must override in subclasses")
    }
}

extension OrderInformationViewController {
    fileprivate func viewSetup() {
        let orderInfoView = OrderInformationView(frame: self.view.frame)
        self.view = orderInfoView
        instructionLabel = orderInfoView.instructionLabel
        infoTextView = orderInfoView.informationTextView
        orderInfoView.yesButton.addTarget(self, action: #selector(yesPressed), for: .touchUpInside)
    }
}
