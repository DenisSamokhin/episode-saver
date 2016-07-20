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
                let showID = dict.objectForKey("themoviedb")
                self.tmdbIDsList.addObject(showID!)
                self.getShowInfoByID(id: showID!.stringValue)
            }
            }, fail: { (error) in
                
        })
    }
    
    func getShowInfoByID(id id: NSString!) {
        APILayer.sharedInstance.getShowInfoByID(id: id, success: { (result) in
            // create model for TV show and add to data source
            }) { (error) in
                
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AllShowsCell", forIndexPath: indexPath) as! AllShowsTableViewCell
        cell.titleLabel.text = "Big Bang Theory"
        cell.descriptionTextView.text = "TV Show description"
        return cell
    }
    
}
