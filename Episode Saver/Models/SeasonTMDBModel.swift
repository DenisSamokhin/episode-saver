//
//  SeasonTMDBModel.swift
//  Episode Saver
//
//  Created by Denis on 7/21/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation

class SeasonTMDBModel: NSObject {
    var airDate: NSString!
    var episodeCount: NSNumber!
    var seasonID: NSNumber!
    var posterPath: NSString?
    var seasonNumber: NSNumber!
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.airDate = dict.objectForKey("air_date") as! String
        self.posterPath = dict.objectForKey("poster_path") as! String
        self.episodeCount = dict.objectForKey("episode_count") as! NSNumber
        self.seasonNumber = dict.objectForKey("season_number") as! NSNumber
        self.seasonID = dict.objectForKey("id") as! NSNumber
    }
}
