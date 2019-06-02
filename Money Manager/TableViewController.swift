//
//  TableViewController.swift
//  Money Manager
//
//  Created by Anna Zhang on 5/27/19.
//  Copyright © 2019 Anna Zhang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    let list = ["bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey","bananas", "honey"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*var count = Int()
        ref.child("users/\(uid)/itemList").observeSingleEvent(of: .value) { (snapshot) in
            let itemList = snapshot.value as? NSArray
            count = itemList?.count ?? 0
        }
        print("HELLOOO")
        return count*/
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let porp = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "purchaseorpaycheck")
        porp.textLabel?.text = list[indexPath.row]
        
        let item = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "item")
        item.textLabel?.text = list[indexPath.row]
        
        let category = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "category")
        category.textLabel?.text = list[indexPath.row]
        
        let amount = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "amount")
        amount.textLabel?.text = list[indexPath.row]
        /*print("HII!!!")
        ref.child("users/\(uid)/itemList").observeSingleEvent(of: .value) { (snapshot) in
            let itemList = snapshot.value as? [NSDictionary]
            
            print(itemList?[indexPath.row]["item"])
            cell.textLabel?.text = itemList?[indexPath.row]["item"] as? String
        }*/
        return item
    }
    
}
