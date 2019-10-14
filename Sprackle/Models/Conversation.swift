//
//  Conversation.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/15/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation

class Conversation {
    
    var senderID:String?
    
    var senderName:String?
    
    var text:String?
    
    var chatID:String?
    
    init(_ senderid: String,_ sendername:String,_ text:String,_ chatID:String) {
        
        self.senderID = senderid
        self.senderName = sendername
        self.text = text
        self.chatID = chatID
        
    }
}
