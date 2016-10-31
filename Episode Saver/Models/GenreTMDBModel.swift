//
//  GenreTMDBModel.swift
//  Episode Saver
//
//  Created by Denis on 7/21/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation

class GenreTMDBModel: NSObject {
    var name: NSString!
    var genreID: NSNumber!
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.name = dict.object(forKey: "name") as! String as NSString!
        self.genreID = dict.object(forKey: "id") as! NSNumber
    }
}
