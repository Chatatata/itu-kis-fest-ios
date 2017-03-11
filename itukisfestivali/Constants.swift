//
//  Constants.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 26.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import Foundation
import UIKit
import Firebase

let screenSize = UIScreen.main.bounds.size

let REF_DATA = FIRDatabase.database().reference()
let REF_EVENTS = REF_DATA.child("events")
let REF_NOTIFICATIONS = REF_DATA.child("notifications")
let REF_GALLERY = REF_DATA.child("gallery")
