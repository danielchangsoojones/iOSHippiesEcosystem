//
//  OrderNoteViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class OrderNoteViewController: UIViewController {
    var noteTextView: UITextView!
    var yesButton: UIButton!
    
    var order: Order!
    
    init(order: Order) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
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
    
    fileprivate func viewSetup() {
        let orderNoteView = OrderNoteView(frame: self.view.frame)
        self.view = orderNoteView
        noteTextView = orderNoteView.noteTextView
        yesButton = orderNoteView.yesButton
        yesButton.addTarget(self, action: #selector(yesPressed), for: .touchUpInside)
    }
}

extension OrderNoteViewController {
    func yesPressed() {
        //Segue to the address vc
    }
}
