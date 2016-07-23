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
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
        }
        return image
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
    }
    
    func downloadImageWithURL(stringURL stringURL: NSString, success: (image: UIImage) -> Void) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let imageName = stringURL.componentsSeparatedByString("/").last
            let imagePath = self.fileInDocumentsDirectory(imageName!)
            if let loadedImage = self.loadImageFromPath(imagePath) {
                dispatch_async(dispatch_get_main_queue()) {
                    success(image: loadedImage)
                }
            } else {
                let image: UIImage? = UIImage.init(data: NSData.init(contentsOfURL: NSURL.init(string: stringURL as String)!)!)!
                if (image != nil) {
                    self.saveImage(image!, path: imagePath)
                    dispatch_async(dispatch_get_main_queue()) {
                        success(image: image!)
                    }
                }
            }
        }
    }
    
    func setMaskToView(view view: UIView, byRoundingCorners corners: UIRectCorner) {
        let radius: CGFloat = view.frame.size.width / 2
        let rounded : UIBezierPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(radius, radius))
        let shape: CAShapeLayer = CAShapeLayer.init()
        shape.path = rounded.CGPath
        view.layer.mask = shape
    }
}
