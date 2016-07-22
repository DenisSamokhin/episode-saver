//
//  ShowDetailsViewController.swift
//  Episode Saver
//
//  Created by Denis on 7/21/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit

class ShowDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var bottomContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var contentVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var topContainerView: UIView!
    var currentShow: ShowTMDBModel!
    var iconImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "TV Shows"
        self.initUI()
    }
    
    func initUI() {
        self.title = "TV Show Details"
        self.contentViewWidthConstraint.constant = self.view.frame.size.width
        //self.contentView.backgroundColor = UIColor.greenColor()
        self.topContainerView.backgroundColor = UIColor.clearColor()
        self.descriptionContainerView.backgroundColor = UIColor.clearColor()
        self.avatarImageView.image = iconImage
        self.avatarImageView.layer.cornerRadius = 45
        self.avatarImageView.clipsToBounds = true
        let labelNameString = NSMutableAttributedString(string:"Title", attributes:[NSFontAttributeName : UIFont.systemFontOfSize(12.0), NSForegroundColorAttributeName : UIColor .grayColor()])
        let titleString = NSMutableAttributedString(string:"\n\(currentShow.title)", attributes:[NSFontAttributeName : UIFont.boldSystemFontOfSize(22.0)])
        labelNameString.appendAttributedString(titleString)
        self.titleLabel.attributedText = labelNameString;
        
        let labelDescriptionString = NSMutableAttributedString(string:"Description", attributes:[NSFontAttributeName : UIFont.systemFontOfSize(12.0), NSForegroundColorAttributeName : UIColor .grayColor()])
        let descriptionString = NSMutableAttributedString(string:"\n\(currentShow.showDescription as! String)", attributes:[NSFontAttributeName : UIFont.systemFontOfSize(14.0)])
        labelDescriptionString.appendAttributedString(descriptionString)
        self.descriptionTextView.attributedText = labelDescriptionString;
        let width: CGFloat = self.view.frame.size.width - 30
        let resultRect = labelDescriptionString.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: [.UsesLineFragmentOrigin, .UsesFontLeading], context: nil)
        self.descriptionContainerHeight.constant = resultRect.size.height + 20;
    }
    
}
