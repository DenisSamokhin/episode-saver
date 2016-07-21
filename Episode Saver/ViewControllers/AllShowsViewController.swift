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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getShowsList()
    }
    
    // MARK: - Logic
    
    func getShowsList() {
        var offset: NSString
        if tableViewDataSource != nil && tableViewDataSource.count > 0 {
            offset = "\(tableViewDataSource.count)"
        }else {
            offset = "0"
        }
        APILayer.sharedInstance.getTVShowsList(offset: offset, success: { (result) in
            for dict in result {
                let showID = dict.objectForKey("themoviedb") as! NSNumber
                self.tmdbIDsList.addObject(showID.stringValue)
            }
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
        
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tmdbIDsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllShowsCell", forIndexPath: indexPath) as! AllShowsTableViewCell
        let showID = self.tmdbIDsList.objectAtIndex(indexPath.row) as! NSString
        self.getShowInfoByID(id: showID, completion: { (show) in
            cell.titleLabel.text = show.title as String;
            cell.descriptionTextView.text = show.showDescription as! String;
        }) { (error) in
            
        }
        
        return cell
    }
    
}
