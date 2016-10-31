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
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var topContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var contentVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var titleLabel: ShowDetailsTitleLabel!
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
        self.topContainerHeightConstraint.constant = self.view.frame.size.width / 1.77777778 + 60;
        //self.contentView.backgroundColor = UIColor.greenColor()
        self.topContainerView.backgroundColor = UIColor.clear
        self.descriptionContainerView.backgroundColor = UIColor.clear
        self.avatarImageView.image = iconImage
        let labelNameString = NSMutableAttributedString(string:"Title", attributes:[NSFontAttributeName : UIFont.systemFont(ofSize: 12.0), NSForegroundColorAttributeName : UIColor.gray])
        let titleString = NSMutableAttributedString(string:"\n\(currentShow.title)", attributes:[NSFontAttributeName : UIFont.boldSystemFont(ofSize: 22.0)])
        labelNameString.append(titleString)
        self.titleLabel.attributedText = labelNameString;
        self.yearLabel.text = self.currentShow.firstAirDate.components(separatedBy: "-").first
        let genresArray: NSArray! = self.currentShow.genres
        var genresString: NSString! = ""
        for (index, element) in genresArray.enumerated() {
            let obj: GenreTMDBModel = element as! GenreTMDBModel
            if genresArray.count == 1 {
                genresString = obj.name
            }else if genresArray.count > 1 {
                genresString = genresString.appending("\(obj.name), ") as NSString!
                if index == genresArray.count-1 {
                    genresString = genresString.substring(to: genresString.length-2) as NSString!
                }
            }
        }
        self.genreLabel.text = genresString as String
        let labelDescriptionString = NSMutableAttributedString(string:"Description", attributes:[NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17.0), NSForegroundColorAttributeName : UIColor .init(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)])
        let descriptionString = NSMutableAttributedString(string:"\n\(currentShow.showDescription as! String)", attributes:[NSFontAttributeName : UIFont.systemFont(ofSize: 17.0)])
        labelDescriptionString.append(descriptionString)
        self.descriptionTextView.attributedText = labelDescriptionString;
        print(descriptionString)
        self.view.layoutIfNeeded()
        let width: CGFloat = self.descriptionTextView.frame.size.width
        let resultRect = labelDescriptionString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        self.descriptionContainerHeight.constant = resultRect.size.height + self.descriptionTextView.frame.origin.y + 20;
        self.view.layoutIfNeeded()
        self.contentVIewHeightConstraint.constant = self.descriptionContainerView.frame.origin.y + self.descriptionContainerView.frame.size.height
        self.view.layoutIfNeeded()
        self.mainScrollView.contentSize = self.contentView.frame.size
    }
    
}
