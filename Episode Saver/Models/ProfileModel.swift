//
//  ProfileModel.swift
//  Episode Saver
//
//  Created by Denis on 7/20/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation

class ProfileModel: NSObject {
    var userID : NSString!
    var fullname : NSString!
    var email : NSString!
    var avatarURL : NSString?
    
    override required init() {
        super.init()
    }
    
    convenience init(dictionary dict: NSDictionary!) {
        self.init()
        self.userID = dict.objectForKey("userID") as! String
        self.fullname = dict.objectForKey("fullname") as! String
        self.email = dict.objectForKey("email") as! String
        self.avatarURL = dict.objectForKey("avatarURL") as! String
    }
}
