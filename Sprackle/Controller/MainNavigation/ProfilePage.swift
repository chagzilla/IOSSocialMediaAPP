//
//  ProfilePage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/12/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfilePage: UIViewController {

    var edit = false
    
    let ProfileImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2
        
        view.layer.cornerRadius = 50
        return view
    }()
    let ProfilePic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 45
        image.layer.masksToBounds = true
        
        image.image = UIImage(named: "NoProfilePic")
        //image.backgroundColor = UIColor.gray
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sprackle"
        label.font = UIFont(name: "StreetGathering", size: 60)
        
        return label
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
    
    let BioLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = "Bio"
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.layer.borderWidth = 1
        label.textAlignment = .center
        return label
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
    
    let SkillPic: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 5
        
        return image
    }()
    
    let EditButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(editBio), for: .touchUpInside)
        return button
    }()
    
    let ContactButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Contacts", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(goToContacts), for: .touchUpInside)
        return button
    }()
    
    let FollowingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Following", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let FollowersButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let SkillLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your SKill"
        return label
    }()
    
    
    let View = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        View.addSubview(titleLabel)
        navigationItem.titleView = View
        
        //self.navigationItem.titleView = titleLabel
        //self.navigationItem.titleView = titleView
        //titleLabel.centerXAnchor.constraint(equalTo: (self.navigationController?.navigationBar.centerXAnchor)!).isActive = true
        //titleLabel.centerYAnchor.constraint(equalTo: (self.navigationController?.navigationBar.centerYAnchor)!).isActive = true
        //self.title = "Sprackle"
        
        
        view.addSubview(ProfileImageView)
        setupProfilePic()

        
        view.addSubview(AttributeOnePic)
        view.addSubview(AttributeTwoPic)
        view.addSubview(AttributeThreePic)
        view.addSubview(SkillPic)
        view.addSubview(SkillLabel)
        setupAttributePics()
        
        view.addSubview(UsernameLabel)
        view.addSubview(NameLabel)
        setupNameLabels()

        view.addSubview(BioLabel)
        setupBio()
        
        view.addSubview(EditButton)
        setupEditButton()
        
        view.addSubview(ContactButton)
        view.addSubview(FollowingButton)
        view.addSubview(FollowersButton)
        setupSocialButtons()
        
        
        
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target:self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        if (Auth.auth().currentUser?.uid != nil)
        {
            DBProvider.Instance.getUser(completion:
                {(value) in

                    
                    self.UsernameLabel.text = value["USERNAME"] as? String
                    if let name = value["NAME"] as? String {
                    
                        self.NameLabel.text = name
                        
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
                    
                    
                    
                    
            }, user: AuthProvider.Instance.userID())
            
            self.ProfilePic.getProfilePicFromFireBase(location: AuthProvider.Instance.userID()+"/profilePic")
        } else
        {
            let loginController = LoginController()
            loginController.navigation = self.parent?.parent as? AppNavigationController
            self.present(loginController, animated: true, completion: nil)
            
        }
    }
    
    @objc func handleMenu() {
        let menu = MenuPage()
        menu.navigation = self.parent?.parent as? AppNavigationController
        present(UINavigationController(rootViewController: menu), animated: true, completion: nil)
        
    }
    
    @objc func goToContacts() {
        let contacts = ContactsPage()
        present(UINavigationController(rootViewController: contacts), animated: true, completion: nil)
    }
    
    @objc func editBio() {
        if edit
        {
            self.BioLabel.isUserInteractionEnabled = true
        }
        else
        {
            self.BioLabel.isUserInteractionEnabled = false
            DBProvider.Instance.updateUser(withID: AuthProvider.Instance.userID(), data: ["BIO": self.BioLabel.text])
            
        }
        self.edit = !self.edit
    }
    
    func setupProfilePic() {
        
        
        ProfileImageView.topAnchor.constraint(equalTo:view.topAnchor, constant: 20).isActive = true
        ProfileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        ProfileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ProfileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ProfileImageView.addSubview(ProfilePic)
    ProfilePic.centerXAnchor.constraint(equalTo:ProfileImageView.centerXAnchor).isActive = true
        ProfilePic.centerYAnchor.constraint(equalTo: ProfileImageView.centerYAnchor).isActive = true
        ProfilePic.heightAnchor.constraint(equalToConstant: 90).isActive = true
        ProfilePic.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
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
        titleLabel.centerXAnchor.constraint(equalTo: View.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: View.topAnchor, constant: -12).isActive = true
        
        UsernameLabel.bottomAnchor.constraint(equalTo: AttributeThreePic.topAnchor, constant: -5).isActive = true
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
    
    func setupEditButton() {
        EditButton.topAnchor.constraint(equalTo: BioLabel.bottomAnchor, constant: 10).isActive = true
        EditButton.heightAnchor.constraint(equalToConstant: 50 ).isActive = true
        EditButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        EditButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupSocialButtons() {
        ContactButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        ContactButton.topAnchor.constraint(equalTo: EditButton.bottomAnchor, constant: 20).isActive = true
        ContactButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ContactButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        FollowingButton.leftAnchor.constraint(equalTo: ContactButton.leftAnchor).isActive = true
        FollowingButton.topAnchor.constraint(equalTo: ContactButton.bottomAnchor, constant: 20).isActive = true
        FollowingButton.heightAnchor.constraint(equalTo: ContactButton.heightAnchor).isActive = true
        FollowingButton.widthAnchor.constraint(equalTo: ContactButton.widthAnchor).isActive = true
        
        FollowersButton.leftAnchor.constraint(equalTo: ContactButton.leftAnchor).isActive = true
        FollowersButton.topAnchor.constraint(equalTo: FollowingButton.bottomAnchor, constant: 20).isActive = true
        FollowersButton.heightAnchor.constraint(equalTo: ContactButton.heightAnchor).isActive = true
        FollowersButton.widthAnchor.constraint(equalTo: ContactButton.widthAnchor).isActive = true
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
    @IBAction func editBio(_ sender: Any) {
        if edit
        {
            self.bio.isUserInteractionEnabled = false
            
            DBProvider.Instance.updateUser(withID: user!, data: ["bio": self.bio.text])
            
        }
        else
        {
            self.bio.isUserInteractionEnabled = true
        }
        self.edit = !self.edit
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
