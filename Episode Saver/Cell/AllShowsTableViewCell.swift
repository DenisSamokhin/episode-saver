//
//  AllShowsTableViewCell.swift
//  Episode Saver
//
//  Created by Denis on 7/20/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit
import DynamicButton

class AllShowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: DynamicButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.setStyle(DynamicButtonStyle.Plus, animated: false)
        addButton.layer.cornerRadius = buttonBackgroundView.frame.size.width / 2
        buttonBackgroundView.layer.cornerRadius = buttonBackgroundView.frame.size.width / 2
        self.buttonBackgroundView.layer.shadowColor = UIColor.black.cgColor
        self.buttonBackgroundView.layer.shadowOpacity = 0.4
        self.buttonBackgroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.buttonBackgroundView.layer.shadowRadius = 5
//        self.buttonBackgroundView.layer.shadowPath = UIBezierPath(rect: self.buttonBackgroundView.bounds).CGPath
//        self.buttonBackgroundView.layer.shouldRasterize = true
    }
    
    
}
