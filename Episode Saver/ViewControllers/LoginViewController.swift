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
        self.navigationController?.isNavigationBarHidden = true
        self.loadMainScreenFlow();
    }

    
    // MARK: - IBActions
    @IBAction func loginButtonClicked(_ sender: AnyObject) {
        if (AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.emailTextField) && AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.passwordTextField)) {
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print(error)
                }else {
                    print(user)
                    self.loadMainScreenFlow()
                }
            })
        }
    }

    @IBAction func signUpButtonClicked(_ sender: AnyObject) {
        if (AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.emailTextField) && AppController.sharedInstance.checkIfTextFieldTextIsVaild(textField: self.passwordTextField)) {
            FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                if (error != nil) {
                    print(error)
                }else {
                    print(user)
                    let postDict = NSMutableDictionary()
                    if user!.email != nil {
                        postDict.setObject(user!.email!, forKey: "email" as NSCopying)
                    }
                    postDict.setObject(user!.uid, forKey: "userID" as NSCopying)
                    if user!.displayName != nil {
                        postDict.setObject(user!.displayName!, forKey: "fullname" as NSCopying)
                    }
                    AppController.dbReference.child("users").child(user!.uid).setValue(postDict)
                }
            })
        }
    }
    
    // MARK: - Logic
    func loadMainScreenFlow() {
        let win: UIWindow? = (UIApplication.shared.delegate?.window)!
        win!.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")
        self.view.window?.makeKey()
    }
}
