//
//  InviteList.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 3/11/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class InviteList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var EventPage:EventCreationPage?
    
    let Table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let cellId = "cellId"
    
    var contacts = [Contact]()
    
    var invited = [String]()
    
    let DoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(finishCreation), for: .touchUpInside)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        button.isOpaque = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Table.delegate = self
        Table.dataSource = self
        
        view.addSubview(Table)
        Table.register(InviteCell.self, forCellReuseIdentifier: cellId)
        setupTable()
        getContacts()
        
        
        view.addSubview(DoneButton)
        setupButton()
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        backBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backBtn
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func finishCreation(){
                dismiss(animated: true, completion: {
            DBProvider.Instance.createEvent(data: (self.EventPage?.data)!)
            self.EventPage?.dismiss(animated: true, completion: nil)
        })
        
    }
    
    func getContacts() {
        DBProvider.Instance.getContacts(completion: { (list) in
            self.contacts = list
            self.Table.reloadData()
        }, user: AuthProvider.Instance.userID())
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InviteCell
        let contact = self.contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.userName
        cell.profileImageView.getProfilePicFromFireBase(location: contact.profilePicL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! InviteCell
        if cell.selectedIt {
            cell.checkButton.layer.borderWidth = 1
            cell.checkButton.backgroundColor = .clear
            removeName(name: contacts[indexPath.row].userID!)
        } else {
            cell.checkButton.backgroundColor = UIColor(r:11, g: 140, b: 181)
            invited.append(contacts[indexPath.row].userID!)
        }
        self.EventPage?.data["INVITED"] = self.invited
        cell.selectedIt = !cell.selectedIt
        
    }
    
    func setupTable() {
        
        Table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        Table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        Table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        Table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setupButton() {
        
        DoneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        DoneButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        DoneButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        DoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func removeName(name: String) {
        if let index = invited.index(of: name) {
            invited.remove(at: index)
        }
    }
    
    
}




