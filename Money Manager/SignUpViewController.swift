//
//  SignUpViewController.swift
//  Money Manager
//
//  Created by Anna Zhang on 2/27/19.
//  Copyright © 2019 Anna Zhang. All rights reserved.

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController : UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pass1TextField: UITextField!
    @IBOutlet weak var pass2TextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    let ref = Database.database().reference()
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let pass1 = pass1TextField.text else {return}
        guard let pass2 = pass2TextField.text else {return}
        guard let name = nameTextField.text else {return}
        
        if pass1 == pass2
        {
            if name != ""
            {
                Auth.auth().createUser(withEmail: email, password: pass1) { user, error in
                    if user != nil && error == nil
                    {
                        print("user created")
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = name
                        changeRequest?.commitChanges(completion: { (error) in
                            if error == nil {
                                print("User display name is", name)
                            }
                            else {
                                self.showAlert(title: "Alert", message: "\(error!.localizedDescription)", handlerOK: { action in
                                    print("action called")
                                }, handlerCancel: {action in
                                    print("action canceled")
                                    self.performSegue(withIdentifier: "gotologin", sender: self)
                                })
                            }
                        })
                        /*
                        print("hi")
                        self.ref.child("lastUser").observeSingleEvent(of: .value, with: {(snapshot) in
                            let lastUser = snapshot.value
                            self.ref.child("\(lastUser)/name").setValue(changeRequest?.displayName)
                            self.ref.child("\(lastUser)/itemList").setValue([["item":"bananas","category": "Groceries", "amount": 5]])
                            let newLastUser = (lastUser as! Int) + 1
                            self.ref.child("lastUser").setValue("\(newLastUser)")
                                                        print("lastUser")
                        })*/
                        
                        print("here")
                        self.performSegue(withIdentifier: "gotologin", sender: self)
                        
                        
                        
                    }
                    else
                    {
                        let errorMessage = error!.localizedDescription
                        print("ERROR creating user:", errorMessage)
                        self.showAlert(title: "Alert", message: errorMessage, handlerOK: { action in
                            print("action called")
                        }, handlerCancel: {action in
                            print("action canceled")
                            self.performSegue(withIdentifier: "gotologin", sender: self)
                        })
                    }
                }
            }
            else
            {
                let errorMessage = "Please enter your name!"
                print("ERROR creating user:", errorMessage)
                self.showAlert(title: "Alert", message: errorMessage, handlerOK: { action in
                    print("action called")
                }, handlerCancel: {action in
                    print("action canceled")
                    self.performSegue(withIdentifier: "gotologin", sender: self)
                })
            }
        }
        else
        {
            let errorMessage = "Your passwords do not match"
            print("ERROR creating user:", errorMessage)
            self.showAlert(title: "Alert", message: errorMessage, handlerOK: { action in
                print("action called")
            }, handlerCancel: {action in
                print("action canceled")
                self.performSegue(withIdentifier: "gotologin", sender: self)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

