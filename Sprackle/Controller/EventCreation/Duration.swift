//
//  Duration.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/5/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class Duration: UIViewController {

    var edit = false
    var EventPage:EventCreationPage?
    var EditPage:EventEditPage?

    let DurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duration: "
        return label
    }()
    
    let DurationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let shortButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("1-2hrs", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(shortClick), for: .touchUpInside)
        return button
    }()
    
    let mediumButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2-4hrs", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(mediumClick), for: .touchUpInside)
        return button
    }()
    
    let longButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("4+hrs", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(longClick), for: .touchUpInside)
        return button
    }()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(finishDuration), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.isOpaque = false
        
        view.addSubview(DurationView)
        setupDuration()
        view.addSubview(DoneButton)
        setupButton()

        // Do any additional setup after loading the view.
    }
    

    @objc func finishDuration() {
        if edit {
            if self.EditPage?.data["DURATION"] != nil {
                self.EditPage?.DurationButton.setTitle(self.EventPage?.data["DURATION"] as? String, for: .normal)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("PICK A DURATION")
            }
        } else {
            if self.EventPage?.data["DURATION"] != nil {
                self.EventPage?.DurationButton.setTitle(self.EventPage?.data["DURATION"] as? String, for: .normal)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("PICK A DURATION")
            }
        }
    
    }
    
    @objc func shortClick() {
        if edit {
            self.EditPage?.data["DURATION"] = "1-2 Hours"
        } else {
            self.EventPage?.data["DURATION"] = "1-2 Hours"
        }
        shortButton.backgroundColor = .gray
        mediumButton.backgroundColor = .white
        longButton.backgroundColor = .white
        
        shortButton.setTitleColor(.white, for: .normal)
        mediumButton.setTitleColor(.black, for: .normal)
        longButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func mediumClick() {
        if edit {
            self.EditPage?.data["DURATION"] = "2-4 Hours"
        } else {
            self.EventPage?.data["DURATION"] = "2-4 Hours"
        }
        shortButton.backgroundColor = .white
        mediumButton.backgroundColor = .gray
        longButton.backgroundColor = .white
        
        shortButton.setTitleColor(.black, for: .normal)
        mediumButton.setTitleColor(.white, for: .normal)
        longButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func longClick() {
        if edit {
            self.EditPage?.data["DURATION"] = "4+ Hours"
        } else {
            self.EventPage?.data["DURATION"] = "4+ Hours"
        }
        shortButton.backgroundColor = .white
        mediumButton.backgroundColor = .white
        longButton.backgroundColor = .gray
        
        shortButton.setTitleColor(.black, for: .normal)
        mediumButton.setTitleColor(.black, for: .normal)
        longButton.setTitleColor(.white, for: .normal)
    }
    
    func setupDuration() {
        
        DurationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DurationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        DurationView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        DurationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7).isActive = true
        
        DurationView.addSubview(DurationLabel)
        DurationView.addSubview(shortButton)
        DurationView.addSubview(mediumButton)
        DurationView.addSubview(longButton)
        setupLabel()
        setupButtons()
        
        
    }
    
    func setupLabel() {
        DurationLabel.topAnchor.constraint(equalTo: DurationView.topAnchor).isActive = true
        DurationLabel.leftAnchor.constraint(equalTo: shortButton.leftAnchor).isActive = true
    }
    
    func setupButtons() {
        
        mediumButton.centerXAnchor.constraint(equalTo: DurationView.centerXAnchor).isActive = true
        mediumButton.centerYAnchor.constraint(equalTo: DurationView.centerYAnchor).isActive = true
        mediumButton.widthAnchor.constraint(equalTo: DurationView.widthAnchor, multiplier: 1/4).isActive = true
        mediumButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        shortButton.centerYAnchor.constraint(equalTo: mediumButton.centerYAnchor).isActive = true
        shortButton.rightAnchor.constraint(equalTo: mediumButton.leftAnchor).isActive = true
        shortButton.widthAnchor.constraint(equalTo: mediumButton.widthAnchor).isActive = true
        shortButton.heightAnchor.constraint(equalTo: mediumButton.heightAnchor).isActive = true
        
        longButton.centerYAnchor.constraint(equalTo: mediumButton.centerYAnchor).isActive = true
        longButton.leftAnchor.constraint(equalTo: mediumButton.rightAnchor).isActive = true
        longButton.widthAnchor.constraint(equalTo: mediumButton.widthAnchor).isActive = true
        longButton.heightAnchor.constraint(equalTo: mediumButton.heightAnchor).isActive = true
        
    }
    
    func setupButton() {
        
        DoneButton.topAnchor.constraint(equalTo: DurationView.bottomAnchor, constant: 25).isActive = true
        DoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DoneButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
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
