//
//  SearchPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/23/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase

class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    let cellId = "cellId"
    var profiles:Bool = true
    //var sessions:Bool = false
    var persons = [Contact]()
    let PeopleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.backgroundColor = .lightGray
        button.setTitle("People", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(clickedPeople), for: .touchUpInside)
        return button
    }()
    
    let SessionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.white
        button.setTitle("Sessions", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(clickedEvent), for: .touchUpInside)
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.white
        return searchBar
    }()
    
    let resultsTable: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(PeopleButton)
        //view.addSubview(SessionsButton)
        view.addSubview(searchBar)
        view.addSubview(resultsTable)
        resultsTable.delegate = self
        resultsTable.dataSource = self
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        resultsTable.register(ContactCell.self, forCellReuseIdentifier: cellId)
        //resultsTable.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Search"
        
        setupStatusButtons()
        setupSearchBar()
        setupTableView()
        let ref = Database.database().reference()
        let child = ref.child("USER")
        child.observe(DataEventType.value, with: {(snapshot) in
            self.persons.removeAll(keepingCapacity: false)
            
            for c in snapshot.children
            {
                
                if let child = c as? DataSnapshot
                {
                    
                    let dic = child.value! as? [String: Any]
                    
                    if let name = dic?["NAME"] as! String? {
                        if dic?["USERID"] as! String != AuthProvider.Instance.userID(){
            
                                self.persons.append(Contact(dic?["NAME"] as! String, dic?["USERNAME"] as! String, (dic?["USERID"] as! String + "/profilePic"), (dic?["USERID"] as! String)))
                            }
                            
                            self.resultsTable.reloadData()
                            
                        }
                    }
                }
            
            
            
        })
        
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        // Do any additional setup after loading the view.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        // You could also change the position, frame etc of the searchBar
    }
    
    func setupStatusButtons() {
        /*
        PeopleButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        PeopleButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        PeopleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PeopleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        SessionsButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        SessionsButton.leftAnchor.constraint(equalTo: PeopleButton.rightAnchor).isActive = true
        SessionsButton.widthAnchor.constraint(equalTo: PeopleButton.widthAnchor).isActive = true
        SessionsButton.heightAnchor.constraint(equalTo: PeopleButton.heightAnchor).isActive = true
 */
    }
    
    func setupSearchBar() {
        
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func setupTableView() {
        
        resultsTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        resultsTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultsTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let ref = Database.database().reference()
        if self.profiles
        {
            
            let child = ref.child("USER")
            child.observe(DataEventType.value, with: {(snapshot) in
                self.persons.removeAll(keepingCapacity: false)
                
                for c in snapshot.children
                {
                    
                    if let child = c as? DataSnapshot
                    {
                        
                        let dic = child.value! as? [String: Any]
                        
                        if let name = dic?["NAME"] as! String? {
                            if dic?["USERID"] as! String != AuthProvider.Instance.userID(){
                               
                                if searchBar.text! == ""
                                {
                                    self.persons.append(Contact(dic?["NAME"] as! String, dic?["USERNAME"] as! String, (dic?["USERID"] as! String + "/profilePic"), (dic?["USERID"] as! String)))
                                }
                                else if name.lowercased().range(of:searchBar.text!.lowercased()) != nil
                                {
                                    
                                    self.persons.append(Contact(dic?["NAME"] as! String, dic?["USERNAME"] as! String, (dic?["USERID"] as! String + "/profilePic"), (dic?["USERID"] as! String)))
                                }
                                
                                
                                self.resultsTable.reloadData()
                                
                            }
                        }
                    }
                }
                
                
            })
        } else {
            
            /*
            let child = ref.child("EVENT")
            child.observe(.value, with: {(snapshot) in
                self.events.removeAll(keepingCapacity: false)
             for c in snapshot.children {
             
                }
            })
             */
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        let contact = self.persons[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.userName
        cell.ProfilePic.getProfilePicFromFireBase(location: contact.profilePicL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = GuestPage()
        guest.USERID = self.persons[indexPath.row].userID
        self.present(UINavigationController(rootViewController: guest), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc func clickedPeople() {
        
        self.profiles = true
        PeopleButton.backgroundColor = .lightGray
        SessionsButton.backgroundColor = .white
        
    }
    
    @objc func clickedEvent() {
        
        self.profiles = false
        PeopleButton.backgroundColor = .white
        SessionsButton.backgroundColor = .lightGray
        
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
