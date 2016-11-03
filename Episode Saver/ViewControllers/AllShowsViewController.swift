//
//  AllShowsViewController.swift
//  Episode Saver
//
//  Created by Denis on 7/20/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit
import DynamicButton

class AllShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var showsTableView: UITableView!
    var tableViewDataSource: NSArray!
    var tmdbIDsList: NSMutableArray! = NSMutableArray()
    var imageURLsList: NSMutableArray! = NSMutableArray()
    var showsList: NSMutableDictionary! = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "TV Shows"
        self.getShowsList()
    }
    
    // MARK: - Logic
    
    func getShowsList() {
        var offset: NSString
        if self.tmdbIDsList != nil && self.tmdbIDsList.count > 0 {
            offset = "\(self.tmdbIDsList.count)" as NSString
        }else {
            offset = "0"
        }
        APILayer.sharedInstance.getTVShowsList(offset: offset, success: { (result) in
            let tempArr = NSMutableArray()
            let tempImagesArray = NSMutableArray()
            for dict in result {
                let showID = (dict as AnyObject).object(forKey: "themoviedb") as! NSNumber
                let posterURL = (dict as AnyObject).object(forKey: "artwork_448x252") as! NSString
                tempArr.add(showID.stringValue)
                tempImagesArray.add(posterURL)
            }
            self.tmdbIDsList.addObjects(from: tempArr as [AnyObject])
            self.imageURLsList.addObjects(from: tempImagesArray as [AnyObject])
            print("Data loaded")
            self.showsTableView.reloadData()
            }, fail: { (error) in
                print(error)
        })
    }
    
    func getShowInfoByID(id: NSString!, completion:@escaping (_ show: ShowTMDBModel) -> Void, fail:@escaping (_ error: NSError) -> Void) {
        APILayer.sharedInstance.getShowInfoByID(id: id, success: { (result) in
            let show: ShowTMDBModel! = ShowTMDBModel.init(dictionary: result)
            completion(show)
        }) { (error) in
            fail(error)
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addButtonClicked(_ sender: AnyObject) {
        let button: DynamicButton! = sender as! DynamicButton
        if button.style == DynamicButtonStyle.plus {
            // Add to list
            button.setStyle(DynamicButtonStyleClose.self, animated: true)
        }else if button.style == DynamicButtonStyle.close {
            button.setStyle(DynamicButtonStylePlus.self, animated: true)
        }
        let point = button.convert(CGPoint.zero, to: self.showsTableView)
        let indexPath = self.showsTableView.indexPathForRow(at: point)
        let showID = self.tmdbIDsList.object(at: (indexPath?.row)!)
        let showModel = self.showsList.object(forKey: showID)
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmdbIDsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width / 1.77777778 + 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllShowsCell", for: indexPath) as! AllShowsTableViewCell
        cell.selectionStyle = .none
        let showID = self.tmdbIDsList.object(at: (indexPath as NSIndexPath).row) as! NSString
        let posterURL = self.imageURLsList.object(at: (indexPath as NSIndexPath).row) as! NSString
        cell.avatarImageView.image = nil
        cell.titleLabel.text = ""
        AppController.sharedInstance.downloadImageWithURL(stringURL: posterURL) { (image) in
            cell.avatarImageView.image = image
        }
        self.getShowInfoByID(id: showID, completion: { (show) in
            self.showsList.setObject(show, forKey: showID)
            cell.titleLabel.text = show.title as String;
        }) { (error) in
            self.getShowInfoByID(id: showID, completion: { (show) in
                self.showsList.setObject(show, forKey: showID)
                cell.titleLabel.text = show.title as String;
            }) { (error) in
                
            }
        }
        if (indexPath as NSIndexPath).row == self.tmdbIDsList.count - 10 {
            self.getShowsList()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showID = self.tmdbIDsList.object(at: (indexPath as NSIndexPath).row)
        let cell = tableView.cellForRow(at: indexPath) as! AllShowsTableViewCell
        let showModel = self.showsList.object(forKey: showID) as! ShowTMDBModel
        let showDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: "ShowDetailsVC") as! ShowDetailsViewController
        showDetailsVC.currentShow = showModel
        showDetailsVC.iconImage = cell.avatarImageView.image
        self.navigationController!.pushViewController(showDetailsVC, animated: true)
    }
    
}
