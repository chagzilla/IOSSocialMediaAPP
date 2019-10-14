//
//  MenuPage.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/23/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import Firebase
class MenuPage: UIViewController {

    var navigation:AppNavigationController?
    /*
     ALL THE STUFF MANAGING THE PREFERENCES PORTION
     This contains the buttons and the label
    */
    let PreferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 25)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Preferences")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        return label
    }()
    
    let QuickAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quick Add Parameters", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(quickAdd), for: .touchUpInside)
        return button
    }()
    
    let AttributeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Attributes", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(attribute), for: .touchUpInside)
        return button
    }()
    
    let SportButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sport", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(sport), for: .touchUpInside)
        return button
    }()
    
    
    /*
     THIS PART MANAGES THE SHOP PORTION
     */
    let SupplyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 25)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Sprackle Supplies")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        return label
    }()
    
    let PaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Payment Method", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()
    let OrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Order History", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()
    let ShippingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shipping Address", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    
    // This is the account management portion
    let AccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 25)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Account")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        return label
    }()
    let NameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Name", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(name), for: .touchUpInside)
        return button
    }()
    let UsernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Username", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(username), for: .touchUpInside)
        return button
    }()
    
    let PasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Password", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(password), for: .touchUpInside)
        return button
    }()
    
    let LogoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    let NotificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 25)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Notification")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        return label
    }()
    
    let PushNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push Notification", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    let EmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set Email Newsletter", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Menu"
        
        
        view.addSubview(PreferenceLabel)
        view.addSubview(QuickAddButton)
        view.addSubview(AttributeButton)
        view.addSubview(SportButton)
        setupPreferences()
        
        view.addSubview(SupplyLabel)
        view.addSubview(PaymentButton)
        view.addSubview(OrderButton)
        view.addSubview(ShippingButton)
        setupSupplies()
        
        view.addSubview(AccountLabel)
        view.addSubview(NameButton)
        view.addSubview(UsernameButton)
        view.addSubview(PasswordButton)
        view.addSubview(LogoutButton)
        setupAccount()
        
        view.addSubview(NotificationLabel)
        view.addSubview(PushNotificationButton)
        view.addSubview(EmailButton)
        setupNotification()
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuPage.back))
        backBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = backBtn
        // Do any additional setup after loading the view.
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func setupPreferences() {
        
        PreferenceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        PreferenceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        PreferenceLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        QuickAddButton.topAnchor.constraint(equalTo: PreferenceLabel.bottomAnchor, constant: 10).isActive = true
        QuickAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        QuickAddButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        QuickAddButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        AttributeButton.topAnchor.constraint(equalTo: QuickAddButton.bottomAnchor).isActive = true
        AttributeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        AttributeButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        AttributeButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        SportButton.topAnchor.constraint(equalTo: AttributeButton.bottomAnchor).isActive = true
        SportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SportButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        SportButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        
        
    }
    
    func setupSupplies() {
        
        SupplyLabel.topAnchor.constraint(equalTo: SportButton.bottomAnchor, constant: 10).isActive = true
        SupplyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        SupplyLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        PaymentButton.topAnchor.constraint(equalTo: SupplyLabel.bottomAnchor, constant: 10).isActive = true
        PaymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PaymentButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        PaymentButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        OrderButton.topAnchor.constraint(equalTo: PaymentButton.bottomAnchor).isActive = true
        OrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        OrderButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        OrderButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        ShippingButton.topAnchor.constraint(equalTo: OrderButton.bottomAnchor).isActive = true
        ShippingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ShippingButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        ShippingButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func setupAccount() {
        
        AccountLabel.topAnchor.constraint(equalTo: ShippingButton.bottomAnchor, constant: 10).isActive = true
        AccountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        AccountLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        NameButton.topAnchor.constraint(equalTo: AccountLabel.bottomAnchor, constant: 10).isActive = true
        NameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NameButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        NameButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        UsernameButton.topAnchor.constraint(equalTo: NameButton.bottomAnchor).isActive = true
        UsernameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        UsernameButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        UsernameButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        PasswordButton.topAnchor.constraint(equalTo: UsernameButton.bottomAnchor).isActive = true
        PasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        PasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        LogoutButton.topAnchor.constraint(equalTo: PasswordButton.bottomAnchor).isActive = true
        LogoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LogoutButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        LogoutButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func setupNotification() {
        
        NotificationLabel.topAnchor.constraint(equalTo: LogoutButton.bottomAnchor, constant: 10).isActive = true
        NotificationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        NotificationLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        PushNotificationButton.topAnchor.constraint(equalTo: NotificationLabel.bottomAnchor, constant: 10).isActive = true
        PushNotificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        PushNotificationButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        PushNotificationButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        EmailButton.topAnchor.constraint(equalTo: PushNotificationButton.bottomAnchor).isActive = true
        EmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        EmailButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        EmailButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    @objc func quickAdd() {
        let view = QuickAddPage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func attribute() {
        let view = AttributePage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func sport() {
        let view = SportPage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func name() {
        let view = NamePage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func username() {
        let view = UsernamePage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func password() {
        let view = PasswordPage()
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    @objc func logout() throws {
        
        try Auth.auth().signOut()
        self.dismiss(animated: true, completion: {
            let loginController = LoginController()
            loginController.navigation = self.navigation
            self.navigation?.present(loginController, animated: true, completion: nil)
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
