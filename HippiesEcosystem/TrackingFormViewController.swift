//
//  FormViewController.swift
//  HippiesEcosystem
//
//  Created by Daniel Jones on 6/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

class TrackingFormViewController: UIViewController {
    var idTextField : UITextField!
    
    var dataStore: TrackingFormDataStore {
        return TrackingFormDataStore(delegate: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        saveButtonSetup()
        idTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let formView = TrackingFormView(frame: self.view.bounds)
        self.view = formView
        self.idTextField = formView.idTextField
        idTextField.delegate = self
    }
    
    func save(id: Double) {
        dataStore.save(id: id)
    }
}

extension TrackingFormViewController {
    func saveButtonSetup() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(getIDText))
        navigationItem.rightBarButtonItem = barButton
    }
    
    func getIDText() {
        let onlyNumberID = idTextField.text?.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        let id: Double? = onlyNumberID?.toDouble()
        if let id = id {
            save(id: id)
        }
    }
}

extension TrackingFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //"" means user is backspacing
        if let text = textField.text, string != "" {
            //Making the text more human readable by adding dashes
            if text.characters.count == 3 {
                textField.text = text + "-"
            } else if text.characters.count == 7 {
                textField.text = text + "-"
            }
        }
        return true
    }
}

extension TrackingFormViewController: TrackingFormDataDelegate {
    func successfullySaved() {
        SCLAlertView().showSuccess("Successful Save", subTitle: "")
        idTextField.text = ""
    }
    
    func recieved(error: Error) {
        SCLAlertView().showError("Error Saving", subTitle: error.localizedDescription)
    }
}
