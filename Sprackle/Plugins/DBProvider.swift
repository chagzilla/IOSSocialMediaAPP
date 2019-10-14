//
//  DBProvider.swift
//  ChatApp
//
//  Created by Wilbert Chagula on 6/16/18.
//  Copyright © 2018 Wilbert Chagula. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DBProvider {
    
    //static func +=<K, V> (left: inout [K:V], right: [K:V]) {
     //   for (k,v) in right {
      //      left[k] = v
       // }
    //}
    
    private static let _instance = DBProvider();
    
    private init() {}
    
    static var Instance: DBProvider {
        return _instance;
    }
    var dbRef: DatabaseReference {
        return Database.database().reference();
    }
    
    var contactsRef: DatabaseReference {
        return dbRef.child("USER")
    }
    var eventsRef: DatabaseReference {
        return dbRef.child("EVENT")
    }
    
    var chatRef: DatabaseReference {
        return dbRef.child("CONVERSATION")
    }
    
    func saveUser(withID: String, data: Dictionary<String, Any>)
    {
        contactsRef.child(withID).setValue(data);
    }
    
    func updateUser(withID: String, data: Dictionary<String, Any>)
    {
        contactsRef.child(withID).updateChildValues(data)
        
    }
    
    func getUser(completion: @escaping ([String: Any]) -> (),user: String) {
        let refArtist = contactsRef.child(user)
        
        refArtist.observeSingleEvent(of: .value, with: {(snapshot) in
            if let value = snapshot.value as? [String: Any] {
                completion(value)
            }
            
        })
        
    }
    
    func getEvent(completion: @escaping ([String: Any]) -> (), event: String) {
        
        let eventObserver = eventsRef.child(event)
        
        eventObserver.observeSingleEvent(of: .value, with: {(snapshot) in
            if let value = snapshot.value as? [String: Any] {
                completion(value)
            }
        })
        
    }
    
    /*
    func getContactList(completion: @escaping ([String]) ->(), user: String) {
    
        let contacts = contactsRef.child(user).child("CONTACTS")
        
    }
 */
    
    func getContacts(completion: @escaping ([Contact]) -> (),user: String)
    {
        //let contacts = contactsRef.child(user).queryLimited(toFirst: 1)
        let contacts = contactsRef.child(user).child("CONTACTS")
        var list = [Contact]()
        contacts.observe( .childAdded, with: {(snapshot) in
            if let value = snapshot.value as? String {
                self.contactsRef.child(value).observeSingleEvent(of: .value, with: {(snapshot) in
                    if let instance = snapshot.value as? [String: Any] {
                        
                        let contact = Contact(instance["NAME"] as! String, instance["USERNAME"] as! String, (instance["USERID"] as! String + "/profilePic"), (instance["USERID"] as! String))
                        
                        list.append(contact)
                        completion(list)
                    }
                })
                
            }
            
            
        })
        
        
    }
    
    func addEventToUser(withID: String, name: String)
    {
        contactsRef.child(withID).child("event").updateChildValues([name:"invited"])
    }
    
    func editEvent(name: String, data: Dictionary<String, Any>)
    {
        eventsRef.child(name).updateChildValues(data)
    }
    func addInviteToEvent(name: String, users: [String])
    {
        eventsRef.child(name).child("invited").setValue(users)
    }
    
    func createChat(userID: [String], names: [String]) -> String{
        let chatID = UUID().uuidString
        contactsRef.child(userID[0]).child("CONVERSATION").child(chatID).setValue(["WITH":names[1],
                                                                                   "WITHID": userID[1]])
        contactsRef.child(userID[1]).child("CONVERSATION").child(chatID).setValue(["WITH":names[0],
                                                                                   "WITHID": userID[0]])
        chatRef.child(chatID).setValue(["MEMBERS":userID])
        return chatID
        
    }
    
    func createGroupChat(names: [String], creator:String, eventID:String) {
        let chatID = UUID().uuidString
        var chatMembers = [String]()
        for name in names {
            
            contactsRef.child(name).child("GROUPCHAT").childByAutoId().setValue(chatID)
            chatMembers.append(name)
            
        }
        chatMembers.append(creator)
        contactsRef.child(creator).child("GROUPCHAT").childByAutoId().setValue(chatID)
        eventsRef.child(eventID).updateChildValues(["CHATID":chatID])
        chatRef.child(chatID).setValue(["MEMBERS":chatMembers])
        
    }
    
    func createEvent(data: Dictionary<String, Any>) {
        let eventID = UUID().uuidString
        contactsRef.child(AuthProvider.Instance.userID()).child("EVENT").child(eventID).setValue(["TYPE":data["TYPE"],
                                                                                                  "STATUS":"Owner"])
        
        eventsRef.child(eventID).setValue(data)
        
        createGroupChat(names: (data["INVITED"] as! [String]), creator: AuthProvider.Instance.userID(), eventID: eventID)
    }
    
    func getEvents(completion: @escaping ([EventData]) -> (), user: String) {
        
        //let contacts = contactsRef.child(user).queryLimited(toFirst: 1)
        let contacts = contactsRef.child(user).child("EVENT")
        var list = [EventData]()
        contacts.observe( .childAdded, with: {(snapshot) in
            let key = snapshot.key
            self.eventsRef.child(key).observeSingleEvent(of: .value, with: {(snapshot) in
                if let instance = snapshot.value as? [String: Any] {
                    if let rsvp = (instance["RSVP"] as? [String]) {
                        let event = EventData(instance["LOCATION"] as! String, instance["DATE"] as! String, (instance["DURATION"] as! String), (instance["TYPE"] as! String),rsvp.count, instance["TIME"] as! String,(snapshot.key))
                        list.append(event)
                    } else {
                        let event = EventData(instance["LOCATION"] as! String, instance["DATE"] as! String, (instance["DURATION"] as! String), (instance["TYPE"] as! String),0, instance["TIME"] as! String,(snapshot.key))
                        list.append(event)
                    }
                    
                    completion(list)
                }
            })
                
            
            
            
        })
        
        
    }
    
    
}
