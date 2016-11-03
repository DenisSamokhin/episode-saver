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
    var genreIDs: NSArray!
    var showID: NSNumber!
    var showHomePageURL: NSString?
    var lastAirDate: NSString?
    var title: NSString!
    var totalEpisodesNumber: NSNumber!
    var seasonsNumber: NSNumber!
    var showDescription: NSString?
    var posterPath: NSString?
    var backdropPath: NSString?
    var popularity: NSNumber!
    var seasons: NSArray!
    var status: NSString!
    var rating: NSNumber!
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.firstAirDate = dict.object(forKey: "first_air_date") as! String as NSString!
        self.showID = dict.object(forKey: "id") as! NSNumber
        self.showHomePageURL = dict.object(forKey: "homepage") as? String as NSString?
        self.lastAirDate = dict.object(forKey: "last_air_date") as? String as NSString?
        self.title = dict.object(forKey: "name") as! String as NSString!
        self.totalEpisodesNumber = dict.object(forKey: "number_of_episodes") as? NSNumber
        self.seasonsNumber = dict.object(forKey: "number_of_seasons") as? NSNumber
        self.showDescription = dict.object(forKey: "overview") as? String as NSString?
        self.popularity = dict.object(forKey: "popularity") as? NSNumber
        self.rating = dict.object(forKey: "vote_average") as? NSNumber
        self.status = dict.object(forKey: "status") as? String as NSString!
        // Parse seasons
        let tempArray = dict.object(forKey: "seasons") as? NSArray
        if tempArray != nil {
            let resultArray = NSMutableArray()
            for s in tempArray! {
                let season: SeasonTMDBModel = SeasonTMDBModel.init(dictionary: s as! NSDictionary)
                resultArray.add(season)
            }
            self.seasons = NSArray.init(array: resultArray)
        }
        // Parse genres
        self.genreIDs = dict.object(forKey: "genre_ids") as? NSArray
        let genreArr = dict.object(forKey: "genres") as? NSArray
        if genreArr != nil {
            let genresResultArray = NSMutableArray()
            for g in genreArr! {
                let genre: GenreTMDBModel = GenreTMDBModel.init(dictionary: g as! NSDictionary)
                genresResultArray.add(genre)
            }
            self.genres = NSArray.init(array: genresResultArray)
        }
        
        // Parse images
        if let tempString = dict.object(forKey: "poster_path") as! String as NSString? {
            self.posterPath = tempString.substring(from: 1) as NSString?
        }
        if let tempString = dict.object(forKey: "backdrop_path") as! String as NSString? {
            self.backdropPath = tempString.substring(from: 1) as NSString?
        }
    }
}
