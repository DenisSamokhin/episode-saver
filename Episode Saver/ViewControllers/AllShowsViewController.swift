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
    var showsList: NSMutableDictionary! = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "TV Shows"
        self.tableViewDataSource = NSArray()
        self.getShowsList()
    }
    
    // MARK: - Logic
    
    func getShowsList() {
        var offset: NSInteger
        if self.tableViewDataSource != nil && self.tableViewDataSource.count > 0 {
            offset = self.tableViewDataSource.count / 20 + 1
        }else {
            offset = 1
        }
        APILayer.sharedInstance.getPopularTVShowsList(page: offset, success: { (result) in
            let tempArr = NSMutableArray.init(array: self.tableViewDataSource)
            tempArr.addObjects(from: result as! [Any])
            self.tableViewDataSource = tempArr
            print("Data loaded")
            self.showsTableView.reloadData()
            }, fail: { (error) in
                print(error)
        })
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
//        let showID = self.tableViewDataSource.object(at: (indexPath?.row)!)
//        let showModel = self.showsList.object(forKey: showID)
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width / 1.77777778 + 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllShowsCell", for: indexPath) as! AllShowsTableViewCell
        cell.selectionStyle = .none
        let model: ShowTMDBModel = self.tableViewDataSource[indexPath.row] as! ShowTMDBModel
        cell.avatarImageView.image = nil
        cell.titleLabel.text = model.title as String
        AppController.sharedInstance.downloadPosterImageWithName(imageName: model.backdropPath!) { (image) in
            cell.avatarImageView.image = image
        }
        if (indexPath as NSIndexPath).row == self.tableViewDataSource.count - 10 {
            self.getShowsList()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: ShowTMDBModel = self.tableViewDataSource[indexPath.row] as! ShowTMDBModel
        let showDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: "ShowDetailsVC") as! ShowDetailsViewController
        showDetailsVC.currentShow = model
        self.navigationController!.pushViewController(showDetailsVC, animated: true)
    }
    
}
