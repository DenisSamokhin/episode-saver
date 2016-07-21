//
//  ShowTMDBModel.swift
//  Episode Saver
//
//  Created by Denis on 7/21/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation

class ShowTMDBModel: NSObject {
    var firstAirDate: NSString!
    var genres: NSArray!
    var showID: NSNumber!
    var showHomePageURL: NSString?
    var lastAirDate: NSString?
    var title: NSString!
    var totalEpisodesNumber: NSNumber!
    var seasonsNumber: NSNumber!
    var showDescription: NSString?
    var posterPath: NSString?
    var popularity: NSNumber!
    var seasons: NSArray!
    var status: NSString!
    var rating: NSNumber!
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.firstAirDate = dict.objectForKey("first_air_date") as! String
        self.showID = dict.objectForKey("id") as! NSNumber
        self.showHomePageURL = dict.objectForKey("homepage") as! String
        self.lastAirDate = dict.objectForKey("last_air_date") as! String
        self.title = dict.objectForKey("original_name") as! String
        self.totalEpisodesNumber = dict.objectForKey("number_of_episodes") as! NSNumber
        self.seasonsNumber = dict.objectForKey("number_of_seasons") as! NSNumber
        self.showDescription = dict.objectForKey("overview") as! String
        self.posterPath = dict.objectForKey("poster_path") as! String
        self.popularity = dict.objectForKey("popularity") as! NSNumber
        self.rating = dict.objectForKey("vote_average") as! NSNumber
        self.status = dict.objectForKey("status") as! String
        // Parse seasons
        let tempArray = dict.objectForKey("seasons") as! NSArray
        let resultArray = NSMutableArray()
        for s in tempArray {
            let season: SeasonTMDBModel = SeasonTMDBModel.init(dictionary: s as! NSDictionary)
            resultArray.addObject(season)
        }
        self.seasons = NSArray.init(array: resultArray)
        // Parse genres
        let genreArr = dict.objectForKey("genres") as! NSArray
        let genresResultArray = NSMutableArray()
        for g in genreArr {
            let genre: GenreTMDBModel = GenreTMDBModel.init(dictionary: g as! NSDictionary)
            genresResultArray.addObject(genre)
        }
        self.genres = NSArray.init(array: genresResultArray)
    }
}
