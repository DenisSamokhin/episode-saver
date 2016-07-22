//
//  AllShowsViewController.swift
//  Episode Saver
//
//  Created by Denis on 7/20/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit

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
            offset = "\(self.tmdbIDsList.count)"
        }else {
            offset = "0"
        }
        APILayer.sharedInstance.getTVShowsList(offset: offset, success: { (result) in
            let tempArr = NSMutableArray()
            let tempImagesArray = NSMutableArray()
            for dict in result {
                let showID = dict.objectForKey("themoviedb") as! NSNumber
                let posterURL = dict.objectForKey("artwork_208x117") as! NSString
                tempArr.addObject(showID.stringValue)
                tempImagesArray.addObject(posterURL)
            }
            self.tmdbIDsList.addObjectsFromArray(tempArr as [AnyObject])
            self.imageURLsList.addObjectsFromArray(tempImagesArray as [AnyObject])
            self.showsTableView.reloadData()
            }, fail: { (error) in
                
        })
    }
    
    func getShowInfoByID(id id: NSString!, completion:(show: ShowTMDBModel) -> Void, fail:(error: NSError) -> Void) {
        APILayer.sharedInstance.getShowInfoByID(id: id, success: { (result) in
            let show: ShowTMDBModel! = ShowTMDBModel.init(dictionary: result)
            completion(show: show)
        }) { (error) in
            fail(error: error)
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        let button = sender as! UIButton
        let point = button.convertPoint(CGPointZero, toView: self.showsTableView)
        let indexPath = self.showsTableView.indexPathForRowAtPoint(point)
        let showID = self.tmdbIDsList.objectAtIndex((indexPath?.row)!)
        let showModel = self.showsList.objectForKey(showID)
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmdbIDsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllShowsCell", forIndexPath: indexPath) as! AllShowsTableViewCell
        let showID = self.tmdbIDsList.objectAtIndex(indexPath.row) as! NSString
        let posterURL = self.imageURLsList.objectAtIndex(indexPath.row) as! NSString
        cell.avatarImageView.image = nil
        cell.titleLabel.text = ""
        cell.descriptionTextView.text = ""
        AppController.sharedInstance.downloadImageWithURL(stringURL: posterURL) { (image) in
            cell.avatarImageView.image = image
        }
        self.getShowInfoByID(id: showID, completion: { (show) in
            self.showsList.setObject(show, forKey: showID)
            cell.titleLabel.text = show.title as String;
            cell.descriptionTextView.text = show.showDescription as! String;
        }) { (error) in
            self.getShowInfoByID(id: showID, completion: { (show) in
                self.showsList.setObject(show, forKey: showID)
                cell.titleLabel.text = show.title as String;
                cell.descriptionTextView.text = show.showDescription as! String;
            }) { (error) in
                
            }
        }
        if indexPath.row == self.tmdbIDsList.count - 15 {
            self.getShowsList()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let showID = self.tmdbIDsList.objectAtIndex(indexPath.row)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AllShowsTableViewCell
        let showModel = self.showsList.objectForKey(showID) as! ShowTMDBModel
        let showDetailsVC = self.storyboard?.instantiateViewControllerWithIdentifier("ShowDetailsVC") as! ShowDetailsViewController
        showDetailsVC.currentShow = showModel
        showDetailsVC.iconImage = cell.avatarImageView.image
        self.navigationController?.pushViewController(showDetailsVC, animated: true)
    }
    
}
