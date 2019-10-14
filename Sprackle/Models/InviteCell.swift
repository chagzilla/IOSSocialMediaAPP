//
//  InviteCell.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 3/11/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation
import UIKit

class InviteCell: UITableViewCell {
    
    var selectedIt = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x:95, y:textLabel!.frame.origin.y, width:textLabel!.frame.width, height:textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x:95, y:detailTextLabel!.frame.origin.y, width:detailTextLabel!.frame.width, height:detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoProfilePic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let checkButton: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(checkButton)
        
        checkButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true
        checkButton.widthAnchor.constraint(equalTo: checkButton.heightAnchor).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
