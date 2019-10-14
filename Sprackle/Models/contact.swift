//
//  User.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 1/24/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation

class Contact {
    
    var name:String?
    var userName:String?
    var profilePicL:String?
    var userID:String?
    
    init(_ name:String, _ userName:String, _ profilePicL:String, _ userID:String) {
        self.name = name
        self.userName = userName
        self.profilePicL = profilePicL
        self.userID = userID
    }
    
}
