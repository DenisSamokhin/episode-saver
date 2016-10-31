//
//  ShowDetailsTitleLabel.swift
//  Episode Saver
//
//  Created by Denis on 7/23/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import UIKit
import Foundation

class ShowDetailsTitleLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
}
