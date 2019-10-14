//
//  ViewController.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/10/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationItem.leftBarButtonItem = UIBarButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target:self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }


}

