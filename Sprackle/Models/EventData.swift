//
//  EventData.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/19/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import Foundation

class EventData {
 
    var location:String?
    var date:String?
    var duration:String?
    var type:String?
    var eventID:String?
    var rsvp:Int?
    var time:String?
    
    init(_ location:String,_ date:String,_ duration:String,_ type:String,_ rsvp:Int,_ time:String,_ eventID:String) {
        
        self.location = location
        self.date = date
        self.duration = duration
        self.type = type
        self.rsvp = rsvp
        self.time = time
        self.eventID = eventID
        
        
    }
    
    
    
}
