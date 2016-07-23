//
//  AllShowsTableViewCell.swift
//  Episode Saver
//
//  Created by Denis on 7/20/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit

class AllShowsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppController.sharedInstance.setMaskToView(view: self.addButton, byRoundingCorners: [.TopLeft, .TopRight])
    }
    
    
}
