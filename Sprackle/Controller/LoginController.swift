//
//  Login.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/10/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    var navigation: AppNavigationController?
    
    var data:[String:String] = [:]
    
    let SprackleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sprackle"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let HeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Organizing the freestyle World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = UIColor.purple
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePress), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.black ,for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
        
    }()
    
    let UsernameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Username"
        tf.backgroundColor = UIColor.white
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Email"
        tf.backgroundColor = UIColor.white
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Password"
        tf.backgroundColor = UIColor.white
        return tf
    }()
    
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.lightGray
        sc.selectedSegmentIndex = 1
        //sc.layer.cornerRadius = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        return sc
    }()
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(SprackleLabel)
        view.addSubview(HeaderLabel)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupText()
        setupContainerView()
        setupLoginButton()
        setupLoginRegisterSegmentedControl()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupText() {
        
        SprackleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        SprackleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        HeaderLabel.topAnchor.constraint(equalTo: SprackleLabel.bottomAnchor).isActive = true
        HeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 150 : 100
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        emailTextFieldHeightAnchor?.isActive = true
        
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = UsernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 0)
        nameTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 1 ? 1/3 : 1/2)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
    }
    
    func setupLoginRegisterSegmentedControl() {
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    func setupContainerView() {
        inputsContainerView.backgroundColor = UIColor.gray
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        // the different fields of this container
        
        //name field
        inputsContainerView.addSubview(UsernameTextField)
        UsernameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        UsernameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        UsernameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        nameTextFieldHeightAnchor = UsernameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //seperator
        inputsContainerView.addSubview(nameSeparatorView)
        nameSeparatorView.topAnchor.constraint(equalTo: UsernameTextField.bottomAnchor).isActive = true
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        //email field
        inputsContainerView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: nameSeparatorView.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //seperator
        inputsContainerView.addSubview(emailSeparatorView)
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        //password field
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
 
        
    }
    
    func setupLoginButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func handlePress() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            if emailTextField.text != "" && passwordTextField.text != ""
            {
                AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                    if message != nil {
                        self.alertTheUser(title: "There was a problem with authentication", message: message!)
                    } else {
                        self.navigation?.viewDidLoad()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
            else
            {
                self.alertTheUser(title: "Email and password are required", message: "please enter a email and password");
            }
        } else {
            if UsernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
                AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!,   loginHandler: {(message) in
                    if message != nil
                    {
                        self.alertTheUser(title: "there was a problem with authentication", message: message!)
                    }
                    else {
                        let registerController = RegistrationPage()
                        registerController.navigation = self.navigation
                        registerController.data["USERNAME"] = self.UsernameTextField.text
                        registerController.data["EMAIL"] = self.emailTextField.text
                        self.emailTextField.text! = ""
                        self.passwordTextField.text! = ""
                        self.UsernameTextField.text! = ""
                        self.dismiss(animated: true, completion: {
                            self.navigation?.present(registerController, animated: true, completion: nil)
                        })

                    }
                    
                }, data: [:])
                            } else {
                alertTheUser(title: "Fill in the Blanks", message: "Fill in valid information for all the blank spaces")
            }
        }
    }
 
    private func alertTheUser(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
}

extension UIColor  {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
