//
//  AddItemViewController.swift
//  Money Manager
//
//  Created by Anna Zhang on 5/26/19.
//  Copyright © 2019 Anna Zhang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var purchasePaycheckSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var purchaseTextField: UITextField!
    @IBOutlet weak var paycheckTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    let ref = Database.database().reference()
    
    var purchaseCategories = ["Groceries", "Utilities", "Housing and Insurance", "Entertainment", "Miscellaneous"]
    var paycheckCategories = ["Income", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paycheckTextField.isHidden = true
        
    }
    
    @IBAction func optionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            print("Selected Purchase")
            paycheckTextField.isHidden = true
            purchaseTextField.isHidden = false
            
        case 1:
            print("Selected Paycheck")
            purchaseTextField.isHidden = true
            paycheckTextField.isHidden = false
        default:
            print("ERROR with segmented control")
        }
    }
    
    @IBAction func addItemButtonClicked(_ sender: UIButton) {
        var categoryTextField = UITextField()
        var type = ""
        switch purchasePaycheckSegmentedControl.selectedSegmentIndex {
        case 0:
            categoryTextField = purchaseTextField
            type = "purchase"
            
        case 1:
            categoryTextField = paycheckTextField
            type = "paycheck"
        default:
            print("ERROR: no currentTextField")
        }
        
        if itemNameTextField.text != "" && categoryTextField.text != "" && amountTextField.text != ""
        {
            let uid = Auth.auth().currentUser?.uid
            let item = ["item": itemNameTextField.text!, "category": categoryTextField.text!, "amount":amountTextField?.text!, "type":type] as! [String : String]
            ref.child("users/\(uid)/itemList").childByAutoId().setValue(item)
            self.performSegue(withIdentifier: "addItem", sender: self)
        
        }
        else
        {
            self.showAlert(title: "Alert", message: "All fields must be filled out correctly", handlerOK: { action in
                print("action called")
            }, handlerCancel: {action in
                print("action canceled")
                self.performSegue(withIdentifier: "cancelAddItem", sender: self)
            })
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == purchaseTextField
        {
            return purchaseCategories[row]
        }
        else if currentTextField == paycheckTextField
        {
            return paycheckCategories[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == purchaseTextField
        {
            return purchaseCategories.count
        }
        else if currentTextField == paycheckTextField
        {
            return paycheckCategories.count
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == purchaseTextField
        {
            purchaseTextField.text = purchaseCategories[row]
            self.view.endEditing(true)
        }
        else if currentTextField == paycheckTextField
        {
            paycheckTextField.text = paycheckCategories[row]
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        currentTextField.inputView = pickerView
    }
}
