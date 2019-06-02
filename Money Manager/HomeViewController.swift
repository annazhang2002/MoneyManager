//
//  HomeViewController.swift
//  Money Manager
//
//  Created by Anna Zhang on 5/26/19.
//  Copyright © 2019 Anna Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController : UIViewController{
    
    @IBOutlet weak var helloNameLabel: UILabel!
    
    let ref = Database.database().reference()
    
    @IBAction func logoutButton(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            print("Logout Success")
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        catch
        {
            print("ERROR: couldn't logout")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = Auth.auth().currentUser?.displayName
        helloNameLabel.text = "Hello \(userName ?? "")"
        
        
        
    }
    
}
