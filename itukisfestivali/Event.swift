//
//  Event.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 26.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import Foundation
import Firebase

class Event {
    var name : String = ""
    var description : String = ""
    var date : String = ""
    var location : String = ""
    var imageURL : URL! = URL(string: "https://scontent-vie1-1.cdninstagram.com/t51.2885-19/s320x320/14592170_151222062002186_4011533599454003200_n.jpg")
    
    init(snapshot: FIRDataSnapshot) {
        if let data = snapshot.value as? Dictionary<String, String> {
            if let eventName = data["name"] {
                self.name = eventName
            }
            
            if let eventDescription = data["description"] {
                self.description = eventDescription
            }
            
            if let eventDate = data["date"] {
                self.date = eventDate
            }
            
            if let eventLocation = data["location"] {
                self.location = eventLocation
            }
            
            if let imageURLString = data["imageURL"] {
                self.imageURL = URL(string: imageURLString)
            }
        }
    }
}
