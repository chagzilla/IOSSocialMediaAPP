//
//  ConversationCell.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/2/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

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
