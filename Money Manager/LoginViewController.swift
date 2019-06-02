//
//  ViewController.swift
//  Money Manager
//
//  Created by Anna Zhang on 2/26/19.
//  Copyright © 2019 Anna Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil
            {
                print("Login Success")
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else
            {
                let errorMessage = error!.localizedDescription
                print("ERROR creating user:", errorMessage)
                self.showAlert(title: "Alert", message: errorMessage, handlerOK: { action in
                    print("action called")
                }, handlerCancel: {action in
                    print("action canceled")
                    self.emailTextField.text = ""
                })
                self.passwordTextField.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "login", sender: self)
        }
    }


}

