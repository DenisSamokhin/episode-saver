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
    
    func initWithDictionary(dictionary dict: NSDictionary!) {
        userID = dict.objectForKey("userID") as! String
        fullname = dict.objectForKey("fullname") as! String
        email = dict.objectForKey("email") as! String
        avatarURL = dict.objectForKey("avatarURL") as! String
    }
}
