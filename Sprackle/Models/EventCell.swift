//
//  EventCell.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/26/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    
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
    
    let rsvpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "rsvp"
        //UIFont.
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(r:64, g:2244, b:208)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.font = UIFont(name: "StreetGathering", size: 55)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "description"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(r:64, g:2244, b:208)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 20.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.font = UIFont(name: "StreetGathering", size: 60)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(dateLabel)
        self.addSubview(locationLabel)
        self.addSubview(typeLabel)
        self.addSubview(eventImage)
        setupCell()
        setupImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
        
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        eventImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor).isActive = true
        eventImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        eventImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        eventImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
        
        
        let fullButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.white
            button.setTitle("View Full", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.layer.cornerRadius = 5
            return button
        }()
        
        eventImage.addSubview(bannerView)
        bannerView.addSubview(descriptionLabel)
        bannerView.addSubview(rsvpLabel)
        eventImage.addSubview(fullButton)
        
        bannerView.leftAnchor.constraint(equalTo: eventImage.leftAnchor).isActive = true
        bannerView.rightAnchor.constraint(equalTo: eventImage.rightAnchor).isActive = true
        bannerView.centerYAnchor.constraint(equalTo: eventImage.centerYAnchor).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive  = true
        bannerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        descriptionLabel.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: -5).isActive = true
        
        rsvpLabel.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive = true
        rsvpLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 20).isActive = true
        
        fullButton.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor).isActive = true
        fullButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        fullButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fullButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }

}
