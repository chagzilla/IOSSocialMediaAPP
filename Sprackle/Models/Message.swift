//
//  Message.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/2/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation

class Message {
    
    var senderID:String?
    
    var senderName:String?
    
    var text:String?
    
    init(_ senderid: String,_ sendername:String,_ text:String) {
        
        self.senderID = senderid
        self.senderName = sendername
        self.text = text
        
    }
    
}
