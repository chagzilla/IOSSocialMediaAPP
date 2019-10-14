//
//  SessionType.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/5/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class SessionType: UIViewController {

    
    var edit = false
    var EventPage:EventCreationPage?
    var EditPage:EventEditPage?
    
    let SessionLabel: UILabel = {
        let label = UILabel()
        label.text = "Session Type:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ExplainLabel:UILabel = {
        let label = UILabel()
        label.text = "The Difference:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let GroupLabel:UILabel = {
        let label = UILabel()
        label.text = "Groups - Only seen by invited"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let GroupExtraLabel:UILabel = {
        let label = UILabel()
        label.text = "(smaller crowds)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let JamLabel:UILabel = {
        let label = UILabel()
        label.text = "Jams - Publicily searchable"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let JamExtraLabel:UILabel = {
        let label = UILabel()
        label.text = "(bigger crowds)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let EventsLabel:UILabel = {
        let label = UILabel()
        label.text = "Events - Sessions that stay in one place"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let EventsExtraLabel:UILabel = {
        let label = UILabel()
        label.text = "(default privacy of Jams)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let SessionsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let GroupButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Group", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(groupClick), for: .touchUpInside)
        return button
    }()
    
    let JamButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Jam", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(jamClick), for: .touchUpInside)
        return button
    }()
    
    let EventsButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Events", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(eventClick), for: .touchUpInside)
        return button
    }()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(finishType), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        view.isOpaque = false
        
        view.addSubview(SessionsView)
        setupSessionType()
        view.addSubview(DoneButton)
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    @objc func finishType(){
        if edit {
            if self.EditPage?.data["TYPE"] != nil {
                self.EditPage?.SessionsButton.setTitle(self.EditPage?.data["TYPE"] as? String, for: .normal)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            if self.EventPage?.data["TYPE"] != nil
            {
                self.EventPage?.SessionsButton.setTitle(self.EventPage?.data["TYPE"] as? String, for: .normal)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("PICK AN EVENT")
            }
        }
        
    }
    
    @objc func groupClick() {
        if edit {
            self.EditPage?.data["TYPE"] = "Group"
        } else {
            self.EventPage?.data["TYPE"] = "Group"
        }
        GroupButton.backgroundColor = .gray
        JamButton.backgroundColor = .white
        EventsButton.backgroundColor = .white
        
        GroupButton.setTitleColor(.white, for: .normal)
        JamButton.setTitleColor(.black, for: .normal)
        EventsButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func jamClick() {
        if edit {
            self.EditPage?.data["TYPE"] = "Jam"
        } else {
            self.EventPage?.data["TYPE"] = "Jam"
        }
        GroupButton.backgroundColor = .white
        JamButton.backgroundColor = .gray
        EventsButton.backgroundColor = .white
        
        GroupButton.setTitleColor(.black, for: .normal)
        JamButton.setTitleColor(.white, for: .normal)
        EventsButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func eventClick() {
        if edit {
            self.EditPage?.data["TYPE"] = "Event"
        } else {
            self.EventPage?.data["TYPE"] = "Event"
        }
        GroupButton.backgroundColor = .white
        JamButton.backgroundColor = .white
        EventsButton.backgroundColor = .gray
        
        GroupButton.setTitleColor(.black, for: .normal)
        JamButton.setTitleColor(.black, for: .normal)
        EventsButton.setTitleColor(.white, for: .normal)
    }
    
    func setupSessionType() {
        
        SessionsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SessionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        SessionsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        SessionsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
        
        SessionsView.addSubview(SessionLabel)
        SessionsView.addSubview(ExplainLabel)
        SessionsView.addSubview(GroupLabel)
        SessionsView.addSubview(GroupExtraLabel)
        SessionsView.addSubview(JamLabel)
        SessionsView.addSubview(JamExtraLabel)
        SessionsView.addSubview(EventsLabel)
        SessionsView.addSubview(EventsExtraLabel)
        SessionsView.addSubview(GroupButton)
        SessionsView.addSubview(JamButton)
        SessionsView.addSubview(EventsButton)
        setupLabels()
        setupButtons()
        //SearchView.addSubview(searchBar)
        //setupSearchBar()
        
        //SearchView.addSubview(worldMap)
        //setupMap()
        
        
    }
    
    func setupLabels() {
        //top label
        SessionLabel.topAnchor.constraint(equalTo: SessionsView.topAnchor, constant: 10).isActive = true
        SessionLabel.leftAnchor.constraint(equalTo: SessionLabel.leftAnchor, constant: 10).isActive = true
        
        //labels below the button
        ExplainLabel.topAnchor.constraint(equalTo: GroupButton.bottomAnchor, constant: 5).isActive = true
        ExplainLabel.centerXAnchor.constraint(equalTo: SessionsView.centerXAnchor).isActive = true
        
        GroupLabel.topAnchor.constraint(equalTo: ExplainLabel.bottomAnchor).isActive = true
        GroupLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
        GroupExtraLabel.topAnchor.constraint(equalTo: GroupLabel.bottomAnchor).isActive = true
        GroupExtraLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
        JamLabel.topAnchor.constraint(equalTo: GroupExtraLabel.bottomAnchor, constant: 20).isActive = true
        JamLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
        JamExtraLabel.topAnchor.constraint(equalTo: JamLabel.bottomAnchor).isActive = true
        JamExtraLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
        EventsLabel.topAnchor.constraint(equalTo: JamExtraLabel.bottomAnchor, constant: 20).isActive = true
        EventsLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
        EventsExtraLabel.topAnchor.constraint(equalTo: EventsLabel.bottomAnchor).isActive = true
        EventsExtraLabel.centerXAnchor.constraint(equalTo: ExplainLabel.centerXAnchor).isActive = true
        
    }
    
    func setupButtons() {
        GroupButton.leftAnchor.constraint(equalTo: SessionsView.leftAnchor).isActive = true
        GroupButton.topAnchor.constraint(equalTo: SessionLabel.bottomAnchor).isActive = true
        GroupButton.widthAnchor.constraint(equalTo: SessionsView.widthAnchor, multiplier: 1/3).isActive = true
        
        JamButton.leftAnchor.constraint(equalTo: GroupButton.rightAnchor).isActive = true
        JamButton.topAnchor.constraint(equalTo: GroupButton.topAnchor).isActive = true
        JamButton.widthAnchor.constraint(equalTo: GroupButton.widthAnchor).isActive = true
        
        EventsButton.leftAnchor.constraint(equalTo: JamButton.rightAnchor).isActive = true
        EventsButton.topAnchor.constraint(equalTo: GroupButton.topAnchor).isActive = true
        EventsButton.widthAnchor.constraint(equalTo: GroupButton.widthAnchor).isActive = true
    }
    
    func setupButton() {
        
        DoneButton.topAnchor.constraint(equalTo: SessionsView.bottomAnchor, constant: 25).isActive = true
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
