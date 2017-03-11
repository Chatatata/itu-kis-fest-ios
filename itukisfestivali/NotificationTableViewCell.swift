//
//  NotificationTableViewCell.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 27.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet var notificationLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
