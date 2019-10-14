//
//  InboxControllerViewController.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/2/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase


class InboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var conversationDic = [String:Conversation]()
    var conversations = [Conversation]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ConversationCell
        cell.textLabel?.text = conversations[indexPath.row].senderName
        cell.detailTextLabel?.text = conversations[indexPath.row].text
        cell.ProfilePic.getProfilePicFromFireBase(location: conversations[indexPath.row].senderID!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    let cellID = "cellID"
    
    let conversationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Conversation", for: .normal)
        return button
    }()
    
    let groupChatButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Group Chat", for: .normal)
        return button
    }()
    
    let conversationTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
        conversationTable.register(ConversationCell.self, forCellReuseIdentifier: cellID)
        conversationTable.delegate = self
        conversationTable.dataSource = self
        
        view.addSubview(conversationButton)
        view.addSubview(groupChatButton)
        setupButtons()
        view.addSubview(conversationTable)
        setupTable()
        getConversations()
    }
    
    func setupButtons() {
        
        conversationButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        conversationButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        conversationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        groupChatButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        groupChatButton.leftAnchor.constraint(equalTo: conversationButton.rightAnchor).isActive = true
        groupChatButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func setupTable() {
        
        conversationTable.topAnchor.constraint(equalTo: conversationButton.bottomAnchor).isActive = true
        conversationTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        conversationTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        conversationTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func filterPeople(_ list: [String]) -> [String]{
        
        return list.filter{ !$0.contains(AuthProvider.Instance.userID())}
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatController = ChatPage(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.chatID = conversations[indexPath.row].chatID
        chatController.title = conversations[indexPath.row].senderName
        self.present(UINavigationController(rootViewController: chatController), animated: true, completion: nil)
    }
    
    func getConversations() {
        DBProvider.Instance.contactsRef.child(AuthProvider.Instance.userID()).child("CONVERSATION").observe(.childAdded, with: {(value) in
            let chatID = value.key
            if let conversation = value.value as? [String:String] {
                let with = conversation["WITH"]
                let withID = conversation["WITHID"]
                DBProvider.Instance.chatRef.child(chatID).child("MESSAGES").queryLimited(toLast: 1).observe(.childAdded, with: {(snapshot) in
                    if let data = snapshot.value as? [String: String] {
                        self.conversationDic[chatID] = Conversation(withID! + "/profilePic", with!, data["TEXT"]!, chatID)
                        self.conversations = Array(self.conversationDic.values)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.conversationTable.reloadData()
                        }
                    }
                })
            }
        })
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
