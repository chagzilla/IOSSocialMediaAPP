//
//  QuickAddPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/23/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class QuickAddPage: UIViewController {

    let QuickAddView: UIView = {
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
        view.addSubview(QuickAddView)
        setupQuickAdd()
        
        // Do any additional setup after loading the view.
    }
    
    func setupQuickAdd() {
        
        QuickAddView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        QuickAddView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        QuickAddView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        QuickAddView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        
        QuickAddView.addSubview(BackButton)
        BackButton.topAnchor.constraint(equalTo: QuickAddView.topAnchor).isActive = true
        BackButton.leftAnchor.constraint(equalTo: QuickAddView.leftAnchor).isActive = true
        BackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        BackButton.widthAnchor.constraint(equalTo: QuickAddView.widthAnchor, multiplier: 0.3).isActive = true
        
        
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
