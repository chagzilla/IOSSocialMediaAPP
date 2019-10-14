//
//  EventsPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/13/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class EventsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var events = [EventData]()
    
    let cellId = "cellId"
    let GroupsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Groups", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let JamsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Jams", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let EventsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Events", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let GoingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Going", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let InvitedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Invited", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let HostingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Hosting", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let CreateEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
        return button
    }()
    
    let EventsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        /*
        button.layer.borderWidth = 1
        button.setTitle("+", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
 */
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Events"
        getEvents()
        
        
        view.addSubview(GroupsButton)
        view.addSubview(JamsButton)
        view.addSubview(EventsButton)
        
        view.addSubview(GoingButton)
        view.addSubview(InvitedButton)
        view.addSubview(HostingButton)
        view.addSubview(CreateEventButton)
        setupButtons()
        
        view.addSubview(EventsTable)
        setupEventsTable()
        //EventsTable.separatorStyle = .none
        EventsTable.delegate = self
        EventsTable.dataSource = self
        EventsTable.register(EventCell.self, forCellReuseIdentifier: cellId)
        
        
        // Do any additional setup after loading the view.
    }
    
    func getEvents() {
        DBProvider.Instance.getEvents(completion: { (list) in
            self.events = list
            self.EventsTable.reloadData()
        }, user: AuthProvider.Instance.userID())
    }
    
    func setupButtons() {
        
        GroupsButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        GroupsButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        GroupsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        GroupsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        JamsButton.leftAnchor.constraint(equalTo: GroupsButton.rightAnchor).isActive = true
        JamsButton.topAnchor.constraint(equalTo: GroupsButton.topAnchor).isActive = true
        JamsButton.widthAnchor.constraint(equalTo: GroupsButton.widthAnchor).isActive = true
        JamsButton.heightAnchor.constraint(equalTo: GroupsButton.heightAnchor).isActive = true
        
        EventsButton.leftAnchor.constraint(equalTo: JamsButton.rightAnchor).isActive = true
        EventsButton.topAnchor.constraint(equalTo: GroupsButton.topAnchor).isActive = true
        EventsButton.widthAnchor.constraint(equalTo: GroupsButton.widthAnchor).isActive = true
        EventsButton.heightAnchor.constraint(equalTo: GroupsButton.heightAnchor).isActive = true
        
        //bottom row
        GoingButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        GoingButton.topAnchor.constraint(equalTo: GroupsButton.bottomAnchor).isActive = true
        GoingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        GoingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        InvitedButton.leftAnchor.constraint(equalTo: GoingButton.rightAnchor).isActive = true
        InvitedButton.topAnchor.constraint(equalTo: GoingButton.topAnchor).isActive = true
        InvitedButton.widthAnchor.constraint(equalTo: GoingButton.widthAnchor).isActive = true
        InvitedButton.heightAnchor.constraint(equalTo: GoingButton.heightAnchor).isActive = true
        
        HostingButton.leftAnchor.constraint(equalTo: InvitedButton.rightAnchor).isActive = true
        HostingButton.topAnchor.constraint(equalTo: GoingButton.topAnchor).isActive = true
        HostingButton.widthAnchor.constraint(equalTo: GoingButton.widthAnchor).isActive = true
        HostingButton.heightAnchor.constraint(equalTo: GoingButton.heightAnchor).isActive = true
        
        CreateEventButton.leftAnchor.constraint(equalTo: HostingButton.rightAnchor).isActive = true
        CreateEventButton.topAnchor.constraint(equalTo: GoingButton.topAnchor).isActive = true
        CreateEventButton.widthAnchor.constraint(equalTo: GoingButton.widthAnchor).isActive = true
        CreateEventButton.heightAnchor.constraint(equalTo: GoingButton.heightAnchor).isActive = true
    }
    
    func setupEventsTable() {
        EventsTable.topAnchor.constraint(equalTo:GoingButton.bottomAnchor).isActive = true
        EventsTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        EventsTable.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        EventsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func createEvent() {
        let view = EventCreationPage()
        present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if events.count == 0 {
            return 1
        }
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventCell
        
        if events.count != 0 {
            
            let event = events[indexPath.row]
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: event.date!)
            attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.dateLabel.attributedText = attributeString
            
            if (event.location?.contains(","))! {
                let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: (event.location?.substring(to: (event.location?.firstIndex(of: ","))!))!
)
                attributeString2.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString2.length))
                cell.locationLabel.attributedText = attributeString2
                
            } else {
                let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: event.location!)
                attributeString2.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString2.length))
                cell.locationLabel.attributedText = attributeString2
            }
            
            let attributeString3: NSMutableAttributedString =  NSMutableAttributedString(string: event.type!)
            attributeString3.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString3.length))
            cell.typeLabel.attributedText = attributeString3
            
            cell.rsvpLabel.text = "RSVP's: \(event.rsvp!)"
            
            //cell.descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
            cell.descriptionLabel.text =  "The \(event.type!) starts at: \(event.time!)"
            
        }
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = Event()
        if events.count != 0 {
            view.eventID = events[indexPath.row].eventID
        }
        self.present(UINavigationController(rootViewController:view), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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
