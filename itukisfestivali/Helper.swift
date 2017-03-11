//
//  Helper.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 27.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
