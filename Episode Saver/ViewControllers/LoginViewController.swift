//
//  LoginViewController.swift
//  Episode Saver
//
//  Created by Denis on 7/19/16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        if (AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.emailTextField) && AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.passwordTextField)) {
            FIRAuth.auth()?.signInWithEmail(self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print(error)
                }else {
                    print(user)
                }
            })
        }
    }

    @IBAction func signUpButtonClicked(sender: AnyObject) {
        if (AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.emailTextField) && AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.passwordTextField)) {
            FIRAuth.auth()?.createUserWithEmail(self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print(error)
                }else {
                    print(user)
                    let postDict = NSMutableDictionary()
                    if user!.email != nil {
                        postDict.setObject(user!.email!, forKey: "email")
                    }
                    postDict.setObject(user!.uid, forKey: "userID")
                    if user!.displayName != nil {
                        postDict.setObject(user!.displayName!, forKey: "fullname")
                    }
                    AppController.dbReference.child("users").child(user!.uid).setValue(postDict)
                }
            })
        }
    }
}
