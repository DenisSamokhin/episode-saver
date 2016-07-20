//
//  AppController.swift
//  Episode Saver
//
//  Created by Denis on 7/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AppController: NSObject {
    static let dbReference = FIRDatabase.database().reference()
    static let sharedInstance = AppController()
    private override init() {}
    
    func checkIfTextFieldTextIsVaild(textField textField: UITextField) -> Bool {
        let textString = textField.text;
        if (textString != nil && textString != "") {
            return true
        }else {
            return false
        }
    }
    
}
