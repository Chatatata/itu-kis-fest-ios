//
//  EventsCollectionViewCell.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 26.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import UIKit
import Kingfisher
import Async

class EventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var eventImage: UIImageView!
    
    @IBOutlet var eventName: UILabel!
    
    @IBOutlet var eventDescription: UILabel!
    
    @IBOutlet var eventDate: UILabel!
    
    @IBOutlet var eventLocation: UILabel!
    
    func configureCell(event: Event){
        Async.main{
            self.eventImage.kf.setImage(with: event.imageURL)
            self.eventName.text = event.name
            self.eventDescription.text = event.description
            self.eventDate.text = event.date
            self.eventLocation.text = event.location
        }
    }
}
