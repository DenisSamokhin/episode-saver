//
//  SeasonTMDBModel.swift
//  Episode Saver
//
//  Created by Denis on 7/21/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation

class SeasonTMDBModel: NSObject {
    var airDate: NSString?
    var episodeCount: NSNumber!
    var seasonID: NSNumber!
    var posterPath: NSString?
    var seasonNumber: NSNumber!
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.airDate = dict.object(forKey: "air_date") as? String as NSString?
        self.posterPath = dict.object(forKey: "poster_path") as? String as NSString?
        self.episodeCount = dict.object(forKey: "episode_count") as! NSNumber
        self.seasonNumber = dict.object(forKey: "season_number") as! NSNumber
        self.seasonID = dict.object(forKey: "id") as! NSNumber
    }
}
