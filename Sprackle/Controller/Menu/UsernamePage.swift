//
//  UsernamePage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 3/30/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class UsernamePage: UIViewController {

    let UsernameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let BackButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Back", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = true
        view.addSubview(UsernameView)
        setupUsername()
        // Do any additional setup after loading the view.
    }
    
    func setupUsername() {
        
        UsernameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UsernameView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        UsernameView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        UsernameView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        
        UsernameView.addSubview(BackButton)
        BackButton.topAnchor.constraint(equalTo: UsernameView.topAnchor).isActive = true
        BackButton.leftAnchor.constraint(equalTo: UsernameView.leftAnchor).isActive = true
        BackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BackButton.widthAnchor.constraint(equalTo: UsernameView.widthAnchor, multiplier: 0.3).isActive = true
        
        
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
