//
//  ContactsPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/13/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import FirebaseStorage

class ContactsPage: UITableViewController {

    let cellId = "cellId"
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        getContacts()
        
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
    
    func getContacts() {
        DBProvider.Instance.getContacts(completion: { (list) in
            self.contacts = list
            self.tableView.reloadData()
        }, user: AuthProvider.Instance.userID())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        let contact = self.contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.userName
        cell.ProfilePic.getProfilePicFromFireBase(location: contact.profilePicL!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guest = GuestPage()
        guest.USERID = self.contacts[indexPath.row].userID
        self.present(UINavigationController(rootViewController: guest), animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ContactCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x:95, y:textLabel!.frame.origin.y, width:textLabel!.frame.width, height:textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x:95, y:detailTextLabel!.frame.origin.y, width:detailTextLabel!.frame.width, height:detailTextLabel!.frame.height)
    }
    
    let ProfileImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 40
        return view
    }()
    
    let ProfilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoProfilePic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(ProfileImageView)
        
        ProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        ProfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ProfileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        ProfileImageView.addSubview(ProfilePic)
        
        ProfilePic.centerXAnchor.constraint(equalTo:ProfileImageView.centerXAnchor).isActive = true
        ProfilePic.centerYAnchor.constraint(equalTo: ProfileImageView.centerYAnchor).isActive = true
        ProfilePic.heightAnchor.constraint(equalToConstant: 70).isActive = true
        ProfilePic.widthAnchor.constraint(equalToConstant: 70).isActive = true
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

