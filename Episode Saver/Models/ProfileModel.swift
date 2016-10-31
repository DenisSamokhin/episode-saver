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
        self.userID = dict.object(forKey: "userID") as! String as NSString!
        self.fullname = dict.object(forKey: "fullname") as! String as NSString!
        self.email = dict.object(forKey: "email") as! String as NSString!
        self.avatarURL = dict.object(forKey: "avatarURL") as! String as NSString?
    }
}
