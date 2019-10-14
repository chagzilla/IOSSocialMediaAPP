//
//  SetupProfilePage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/12/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase

class SetupProfilePage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var navigation: AppNavigationController?
    
    var data:[String: String] = [:]
    
    let SprackleLabel: UILabel = {
        let l = UILabel()
        l.text = "Sprackle"
        l.font = l.font.withSize(30)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    let GoalLabel: UILabel = {
        let l = UILabel()
        l.text = "Organizing the freestyle world"
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        
        return l
    }()
    let StepLabel: UILabel = {
        let l = UILabel()
        l.text = "Step 3: Final Touches"
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoProfilePic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfilePick)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let selectButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pick Image", for: .normal)
        button.backgroundColor = UIColor(r: 0, g: 137, b: 249)
        button.layer.cornerRadius = 16
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(selectProfilePick), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let bioTextbox:UITextView = {
        let text = UITextView()
        text.text = "Tell the world About yourself!"
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.clear
        text.textColor = UIColor.black
        text.isEditable = true
        text.layer.borderWidth = 1
        return text
        
    }()
    
    let doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDone() {
        self.data["BIO"] = bioTextbox.text
        self.data["NAME"] = nameTextField.text
        self.data["USERID"] = AuthProvider.Instance.userID()
        bioTextbox.text = ""
        nameTextField.text = ""
        if let image = profileImageView.image {
            DBProvider.Instance.updateUser(withID: AuthProvider.Instance.userID(), data: self.data)
            if let user = Auth.auth().currentUser?.uid {
                let storageRef = Storage.storage().reference().child(user).child("profilePic")
                if let uploadData = image.pngData(){
                    storageRef.putData(uploadData, metadata: nil, completion:
                        { (metadata, error) in
                            
                            if error != nil {
                                return
                            }
                            else {
                                DBProvider.Instance.updateUser(withID: AuthProvider.Instance.userID(), data: self.data)
                                self.dismiss(animated: true, completion: {
                                    self.navigation?.viewDidLoad()
                                })
                            }
                            
                    })
                }
            }

        }
        
        
    }
    
    @objc func selectProfilePick() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage{
            selectedImageFromPicker = UIImage(data: editedImage.jpegData(compressionQuality: 0.1)!)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImageFromPicker = UIImage(data: originalImage.jpegData(compressionQuality: 0.1)!)
        }
        
        profileImageView.image = selectedImageFromPicker
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.white
        view.addSubview(SprackleLabel)
        view.addSubview(GoalLabel)
        view.addSubview(StepLabel)
        setupText()
        view.addSubview(profileImageView)
        view.addSubview(selectButton)
        setupImage()
        setupButton()
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        setupName()
        view.addSubview(bioLabel)
        view.addSubview(bioTextbox)
        setupBio()
        view.addSubview(doneButton)
        setupButtons()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

        // Do any additional setup after loading the view.
    }
    
    func setupText() {
        SprackleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SprackleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        SprackleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        SprackleLabel.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        GoalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        GoalLabel.topAnchor.constraint(equalTo: SprackleLabel.bottomAnchor).isActive = true
        GoalLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        GoalLabel.heightAnchor.constraint(equalToConstant:25).isActive = true
        
        StepLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        StepLabel.topAnchor.constraint(equalTo: GoalLabel.bottomAnchor).isActive = true
        StepLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        StepLabel.heightAnchor.constraint(equalToConstant:25).isActive = true
        
        
        
    }
    
    func setupImage() {
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: StepLabel.bottomAnchor, constant: 20).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        profileImageView.layer.cornerRadius = view.frame.height / 10
        
    }
    
    func setupButton() {
        selectButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupName() {
        
        nameLabel.topAnchor.constraint(equalTo: selectButton.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5).isActive = true
    }
    
    func setupBio() {
        
        bioLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        bioLabel.leftAnchor.constraint(equalTo: bioTextbox.leftAnchor).isActive = true
        
        bioTextbox.topAnchor.constraint(equalTo: bioLabel.bottomAnchor).isActive = true
        bioTextbox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bioTextbox.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        bioTextbox.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
    
    func setupButtons() {
        
        doneButton.topAnchor.constraint(equalTo: bioTextbox.bottomAnchor, constant: 50).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/12).isActive = true
        
       
        
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
