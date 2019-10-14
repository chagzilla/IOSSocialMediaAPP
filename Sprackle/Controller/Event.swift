//
//  Event.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/19/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit
import MapKit

class Event: UIViewController {
    
    var eventID:String?
    
    var pin:MKPlacemark?
    
    var location:String?

    var chatID:String?
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Time")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.layer.masksToBounds = true
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Location")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.layer.masksToBounds = true
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Type")
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.layer.masksToBounds = true
        return label
    }()
    
    let eventImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "City")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let rsvpNumber:UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = label.font.withSize(25)
        label.text = "0"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationNumber:UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = label.font.withSize(25)
        label.text = "0"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let daysAway:UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = label.font.withSize(25)
        label.text = "0"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inviteButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Manage Invites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        return button
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        //label.font = label.font.withSize(25)
        label.text = "name"
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.setTitle("Copy Pin Location", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        return button
    }()
    
    let chatButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white
        button.setTitle("See Chat", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(eventImage)
        view.addSubview(inviteButton)
        view.addSubview(locationButton)
        view.addSubview(chatButton)
        setupPage()
        setupImage()
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target:self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        if let eventID = self.eventID {
            DBProvider.Instance.getEvent(completion: {(list) in
                
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (list["DATE"] as! String))
                attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                self.dateLabel.attributedText = attributeString
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd,yyyy"
                let date = dateFormatter.date(from: (list["DATE"] as! String))
                let calendar = Calendar.current
                let firstDate = Date()
                
                // Replace the hour (time) of both dates with 00:00
                let date1 = calendar.startOfDay(for: firstDate)
                let date2 = calendar.startOfDay(for: date!)
                
                let components = calendar.dateComponents([.day], from: date1, to: date2)
                self.daysAway.text = String(components.day!)
                self.durationNumber.text = (list["DURATION"] as! String)
                
                if (list["LOCATION"] as! String).contains(",") {
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: (list["LOCATION"] as! String).substring(to: ((list["LOCATION"] as! String).firstIndex(of: ","))!))
                    attributeString2.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString2.length))
                    self.locationLabel.attributedText = attributeString2
                    
                } else {
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: (list["DATE"] as! String))
                    attributeString2.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString2.length))
                    self.locationLabel.attributedText = attributeString2
                }
                
                if let name = list["CREATOR"] {
                    self.nameLabel.text = "(Found through: \(name))"
                }
                
                if let rsvp = list["RSVP"] as? [String] {
                    self.rsvpNumber.text = "\(rsvp.count)"
                }
                
                if let id = list["CHATID"] as? String {
                    self.chatID = id
                }
                
                //MKPlacemark(
                
                self.pin = MKPlacemark(coordinate: CLLocationCoordinate2DMake(list["LATITUDE"] as! CLLocationDegrees, list["LONGITUDE"] as! CLLocationDegrees))
                self.location = (list["LOCATION"] as! String)

                
                let attributeString3: NSMutableAttributedString =  NSMutableAttributedString(string: (list["TYPE"] as! String))
                attributeString3.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, attributeString3.length))
                self.typeLabel.attributedText = attributeString3
                
            }, event: eventID)
        }
        
        self.navigationController?.navigationBar.isTranslucent = false

        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(MenuPage.back))
        backBtn.tintColor = .black
        self.navigationItem.leftBarButtonItem = backBtn
        
        // Do any additional setup after loading the view.
    }
    
    @objc func back(_ sender: UIBarButtonItem)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleEdit() {
        let view = EventEditPage()
        view.eventID = self.eventID
        view.DurationButton.setTitle(self.durationNumber.text, for: .normal)
        view.LocationButton.setTitle(self.locationLabel.text, for: .normal)
        view.SessionsButton.setTitle(self.typeLabel.text, for: .normal)
        view.TimeButton.setTitle(self.dateLabel.text, for: .normal)
        present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
    
    @objc func getChat() {
        let view = ChatPage()
        view.chatID = self.chatID
        present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }
    
    @objc func getDirections() {
        
        if let selectedPin = self.pin {
            let mapItem = MKMapItem(placemark: selectedPin)
            mapItem.name = self.location
            //mapItem.
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
        
    }
    
    func setupPage() {
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
        eventImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        eventImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        eventImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        eventImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        
        locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        chatButton.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 25).isActive = true
        chatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        chatButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        inviteButton.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 50).isActive = true
        inviteButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inviteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inviteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
    }
    
    
    func setupImage() {
        
        let bannerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
            view.isOpaque = false
            view.layer.masksToBounds = true
            return view
        }()
        
        let rsvpLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "rsvp"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(r:64, g:2244, b:208)
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowRadius = 20.0
            label.layer.shadowOpacity = 1.0
            label.layer.shadowOffset = CGSize(width: 4, height: 4)
            //label.font = UIFont(name: "StreetGathering", size: 68)
            return label
        }()
        
        let daysLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Days Away"
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(r:64, g:2244, b:208)
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowRadius = 20.0
            label.layer.shadowOpacity = 1.0
            label.layer.shadowOffset = CGSize(width: 4, height: 4)
            //label.font = UIFont(name: "StreetGathering", size: 68)
            return label
        }()
        
        let durationLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor(r:64, g:2244, b:208)
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowRadius = 20.0
            label.layer.shadowOpacity = 1.0
            label.layer.shadowOffset = CGSize(width: 4, height: 4)
            label.text = "Duration"
            return label
        }()
        
        
        
        eventImage.addSubview(typeLabel)
        eventImage.addSubview(bannerView)
        bannerView.addSubview(daysLabel)
        bannerView.addSubview(rsvpLabel)
        bannerView.addSubview(daysAway)
        bannerView.addSubview(rsvpNumber)
        bannerView.addSubview(durationNumber)
        bannerView.addSubview(durationLabel)
        eventImage.addSubview(nameLabel)
        
        daysAway.topAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        daysAway.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true
        
        rsvpNumber.topAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        rsvpNumber.centerXAnchor.constraint(equalTo: daysAway.leftAnchor, constant: -100).isActive = true
        
        durationNumber.topAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        durationNumber.centerXAnchor.constraint(equalTo: daysAway.rightAnchor, constant: 100).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: eventImage.topAnchor).isActive = true
        typeLabel.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive = true
        
        bannerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        bannerView.leftAnchor.constraint(equalTo: eventImage.leftAnchor).isActive = true
        bannerView.rightAnchor.constraint(equalTo: eventImage.rightAnchor).isActive = true
        //bannerView.centerYAnchor.constraint(equalTo: eventImage.centerYAnchor).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive  = true
        bannerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        daysLabel.centerXAnchor.constraint(equalTo: daysAway.centerXAnchor).isActive = true
        daysLabel.topAnchor.constraint(equalTo: daysAway.bottomAnchor).isActive = true
        
        rsvpLabel.centerXAnchor.constraint(equalTo: rsvpNumber.centerXAnchor).isActive = true
        rsvpLabel.topAnchor.constraint(equalTo: rsvpNumber.bottomAnchor).isActive = true
        
        durationLabel.centerXAnchor.constraint(equalTo: durationNumber.centerXAnchor).isActive = true
        durationLabel.topAnchor.constraint(equalTo: durationNumber.bottomAnchor).isActive = true
        
        
        
        
        
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
