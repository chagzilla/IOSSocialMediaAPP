//
//  GuestPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/12/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase

class GuestPage: UIViewController {

    var USERID:String?
    
    var name:String?
    var hasChat = false
    
    let ProfilePic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.image = UIImage(named: "NoProfilePic")
        //image.backgroundColor = UIColor.gray
        return image
    }()
    
    let SkillPic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 5
        return image
    }()
    
    let AttributeOnePic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 5
        return image
    }()
    
    let AttributeTwoPic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 5

        return image
    }()
    
    let AttributeThreePic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 5

        return image
    }()
    
    let NameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    let UsernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UsernameName"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    let BioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bio"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
    }()
    
    let FollowButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        return button
    }()
    
    let MessageButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleMessages), for: .touchUpInside)
        return button
    }()
    let SkillLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your SKill"
        return label
    }()
    
    @objc func handleMessages() {
        let chat = ChatPage(collectionViewLayout: UICollectionViewFlowLayout())
        DBProvider.Instance.contactsRef.child(AuthProvider.Instance.userID()).child("CONVERSATION").observeSingleEvent(of: .value, with: {(value) in
            let children = value.children
            var key:String?
            for child in children {
                let kid = child as? DataSnapshot
                
                let diction = kid?.value as? [String:String]
                if diction!["WITH"] == self.NameLabel.text {
                    key = kid!.key
                    self.hasChat = true
                }
            }
                if !self.hasChat {
                 
                    DBProvider.Instance.getUser(completion: {(value) in
                        if let myName = value["NAME"] as? String {
                            chat.chatID = DBProvider.Instance.createChat(userID: [AuthProvider.Instance.userID(), self.USERID!], names: [myName, self.name!])
                            self.present(UINavigationController(rootViewController: chat), animated: true, completion: nil)
                        }
                    }, user: AuthProvider.Instance.userID())
                    
                    
                } else {
                    chat.chatID = key
                    self.present(UINavigationController(rootViewController: chat), animated: true, completion: nil)
                }
            
        })
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        view.addSubview(ProfilePic)
        view.addSubview(SkillPic)
        view.addSubview(AttributeOnePic)
        view.addSubview(AttributeTwoPic)
        view.addSubview(AttributeThreePic)
        view.addSubview(UsernameLabel)
        view.addSubview(NameLabel)
        view.addSubview(BioLabel)
        view.addSubview(FollowButton)
        view.addSubview(MessageButton)
        view.addSubview(SkillLabel)
        setupProfilePic()
        setupAttributePics()
        setupNameLabels()
        setupBio()
        setupButtons()
        DBProvider.Instance.getUser(completion:
            {(value) in
                
                
                self.UsernameLabel.text = value["USERNAME"] as? String
                if let name = value["NAME"] as? String {
                    
                    self.NameLabel.text = name
                    self.name = name
                    
                }
                if let bio = value["BIO"] as? String {
                    
                    self.BioLabel.text = bio
                    
                }
                if let one = value["AONE"] as? String {
                    
                    self.AttributeOnePic.image = self.picSetter(pic: one)
                    
                }
                if let two = value["ATWO"] as? String {
                    
                    self.AttributeTwoPic.image = self.picSetter(pic: two)
                    
                }
                if let three = value["ATHREE"] as? String {
                    
                    self.AttributeThreePic.image = self.picSetter(pic: three)
                    
                }
                if let skill = value["SKILL"] as? String {
                    
                    self.SkillLabel.text = skill
                    
                }
                

                
                
                
                
        }, user: self.USERID!)
        
        self.ProfilePic.getProfilePicFromFireBase(location: self.USERID!+"/profilePic")
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuPage.back))
        backBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = backBtn
        // Do any additional setup after loading the view.
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setupProfilePic() {
        
        ProfilePic.topAnchor.constraint(equalTo:view.topAnchor, constant: 20).isActive = true
        ProfilePic.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        ProfilePic.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ProfilePic.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func setupAttributePics() {
        
        SkillPic.bottomAnchor.constraint(equalTo: AttributeThreePic.bottomAnchor).isActive = true
        SkillPic.rightAnchor.constraint(equalTo: AttributeOnePic.leftAnchor, constant: -10).isActive = true
        SkillPic.heightAnchor.constraint(equalToConstant: 60).isActive = true
        SkillPic.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        AttributeOnePic.bottomAnchor.constraint(equalTo: AttributeThreePic.bottomAnchor).isActive = true
        AttributeOnePic.rightAnchor.constraint(equalTo: AttributeTwoPic.leftAnchor, constant: -10).isActive = true
        AttributeOnePic.heightAnchor.constraint(equalTo: AttributeThreePic.heightAnchor).isActive = true
        AttributeOnePic.widthAnchor.constraint(equalTo: AttributeThreePic.widthAnchor).isActive = true
        
        AttributeTwoPic.bottomAnchor.constraint(equalTo: AttributeThreePic.bottomAnchor).isActive = true
        AttributeTwoPic.rightAnchor.constraint(equalTo: AttributeThreePic.leftAnchor, constant: -10).isActive = true
        AttributeTwoPic.heightAnchor.constraint(equalTo: AttributeThreePic.heightAnchor).isActive = true
        AttributeTwoPic.widthAnchor.constraint(equalTo: AttributeThreePic.widthAnchor).isActive = true
        
        AttributeThreePic.bottomAnchor.constraint(equalTo: ProfilePic.bottomAnchor, constant: -20).isActive = true
        AttributeThreePic.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        AttributeThreePic.heightAnchor.constraint(equalToConstant: 50).isActive = true
        AttributeThreePic.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        SkillLabel.topAnchor.constraint(equalTo: SkillPic.bottomAnchor).isActive = true
        SkillLabel.centerXAnchor.constraint(equalTo: SkillPic.centerXAnchor).isActive = true
        
    }
    
    func setupNameLabels() {
        
        UsernameLabel.bottomAnchor.constraint(equalTo: AttributeThreePic.topAnchor, constant: -10).isActive = true
        UsernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        UsernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //UsernameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        NameLabel.bottomAnchor.constraint(equalTo: UsernameLabel.topAnchor).isActive = true
        NameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        NameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func setupBio() {
        
        BioLabel.topAnchor.constraint(equalTo: ProfilePic.bottomAnchor, constant: 10).isActive = true
        BioLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        BioLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        BioLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupButtons() {
        FollowButton.topAnchor.constraint(equalTo: BioLabel.bottomAnchor).isActive = true
        FollowButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        FollowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        FollowButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        MessageButton.topAnchor.constraint(equalTo: FollowButton.topAnchor).isActive = true
        MessageButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        MessageButton.widthAnchor.constraint(equalTo: FollowButton.widthAnchor).isActive = true
        MessageButton.heightAnchor.constraint(equalTo: FollowButton.heightAnchor).isActive = true
    }
    
    func picSetter(pic: String) -> UIImage {
        switch pic {
        case "noob":
            return #imageLiteral(resourceName: "Noob")
        case "lens":
            return #imageLiteral(resourceName: "Behind The Lens")
        case "park":
            return #imageLiteral(resourceName: "Park")
        case "sender":
            return #imageLiteral(resourceName: "Sender")
        case "street":
            return #imageLiteral(resourceName: "Street")
        case "tech":
            return #imageLiteral(resourceName: "Tech as Heck")
        default:
            return #imageLiteral(resourceName: "Noob")
        }
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
