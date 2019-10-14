//
//  EventCreationPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/23/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class EventCreationPage: UIViewController {

    let LABEL_OFFSET = 20
    var data = [String:Any]()
    
    let SessionTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Session Type:"
        return label
        
    }()
    
    let SessionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Pick One", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(loadType), for: .touchUpInside)
        return button
    }()
    
    let TimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Start Time:"
        return label
        
    }()
    
    let TimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Pick a Time", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(loadTime), for: .touchUpInside)
        return button
    }()
    
    let DurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Duration:"
        return label
        
    }()
    
    let DurationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Choose the Length", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(loadDuration), for: .touchUpInside)
        return button
    }()
    
    let LocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Start Location:"
        return label
        
    }()
    
    let LocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Pick a Location", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(loadSearch), for: .touchUpInside)
        return button
    }()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(sendData), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    @objc func sendData() {
        
        print(self.data)
        let view = InviteList()
        view.EventPage = self
        self.present(UINavigationController(rootViewController: view), animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Creation Page"
        DBProvider.Instance.getUser(completion: {(list) in
            self.data["CREATOR"] = list["USERNAME"]
        }, user: AuthProvider.Instance.userID())
        
        view.addSubview(SessionTypeLabel)
        view.addSubview(SessionsButton)
        setupType()
        
        view.addSubview(TimeLabel)
        view.addSubview(TimeButton)
        setupTime()
        
        view.addSubview(DurationLabel)
        view.addSubview(DurationButton)
        setupDuration()
        
        view.addSubview(LocationLabel)
        view.addSubview(LocationButton)
        setupLocation()
        
        view.addSubview(DoneButton)
        setupDone()
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuPage.back))
        backBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backBtn
        // Do any additional setup after loading the view.
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func loadSearch() {
        let view = FullSearchMap()
        view.EventPage = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
    
    @objc func loadType() {
        let view = SessionType()
        view.EventPage = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func loadDuration() {
        let view = Duration()
        view.EventPage = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func loadTime() {
        let view = EventDate()
        view.EventPage = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    
    
    
    func setupType() {
        
        SessionTypeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        SessionTypeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(LABEL_OFFSET)).isActive = true
        SessionTypeLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        SessionsButton.topAnchor.constraint(equalTo: SessionTypeLabel.bottomAnchor).isActive = true
        SessionsButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        SessionsButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        SessionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setupTime() {
        
        TimeLabel.topAnchor.constraint(equalTo: SessionsButton.bottomAnchor, constant: 75).isActive = true
        TimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(LABEL_OFFSET)).isActive = true
        TimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        TimeButton.topAnchor.constraint(equalTo: TimeLabel.bottomAnchor).isActive = true
        TimeButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        TimeButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        TimeButton.heightAnchor.constraint(equalTo: SessionsButton.heightAnchor).isActive = true
        
    }
    
    func setupDuration() {
        
        DurationLabel.topAnchor.constraint(equalTo: TimeButton.bottomAnchor, constant: 75).isActive = true
        DurationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(LABEL_OFFSET)).isActive = true
        DurationLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        DurationButton.topAnchor.constraint(equalTo: DurationLabel.bottomAnchor).isActive = true
        DurationButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        DurationButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        DurationButton.heightAnchor.constraint(equalTo: TimeButton.heightAnchor).isActive = true
        
    }
    
    func setupLocation() {
        
        LocationLabel.topAnchor.constraint(equalTo: DurationButton.bottomAnchor, constant: 75).isActive = true
        LocationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(LABEL_OFFSET)).isActive = true
        LocationLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        LocationButton.topAnchor.constraint(equalTo: LocationLabel.bottomAnchor).isActive = true
        LocationButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        LocationButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        LocationButton.heightAnchor.constraint(equalTo: DurationButton.heightAnchor).isActive = true
        
    }
    
    func setupDone() {
        
        DoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DoneButton.topAnchor.constraint(equalTo: LocationButton.bottomAnchor, constant: 10).isActive = true
        DoneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        DoneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
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
