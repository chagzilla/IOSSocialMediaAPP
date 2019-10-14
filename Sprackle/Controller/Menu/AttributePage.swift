//
//  AttributePage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 3/30/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class AttributePage: UIViewController {

    let AttributeView: UIView = {
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
        view.addSubview(AttributeView)
        setupAttribute()
        // Do any additional setup after loading the view.
    }
    
    func setupAttribute() {
        
        AttributeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AttributeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        AttributeView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        AttributeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        AttributeView.addSubview(BackButton)
        BackButton.topAnchor.constraint(equalTo: AttributeView.topAnchor).isActive = true
        BackButton.leftAnchor.constraint(equalTo: AttributeView.leftAnchor).isActive = true
        BackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BackButton.widthAnchor.constraint(equalTo: AttributeView.widthAnchor, multiplier: 0.3).isActive = true
        
        
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
