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
    fileprivate override init() {}
    
    func checkIfTextFieldTextIsVaild(textField: UITextField) -> Bool {
        let textString = textField.text;
        if (textString != nil && textString != "") {
            return true
        }else {
            return false
        }
    }
    
    func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path
    }
    
    func loadImageFromPath(_ path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
        }
        return image
    }
    
    func saveImage (_ image: UIImage, path: String ) {
        let pngImageData = UIImagePNGRepresentation(image)
        _ = (try? pngImageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
    }
    
    func downloadPosterImageWithName(imageName: NSString, success: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let imagePath = self.fileInDocumentsDirectory(imageName as String)
            if let loadedImage = self.loadImageFromPath(imagePath) {
                DispatchQueue.main.async {
                    success(loadedImage)
                }
            } else {
                let imageURL = "\(kImagesStorageURL!)\(kPosterSize)/\(imageName)"
                let image: UIImage? = UIImage.init(data: try! Data.init(contentsOf: URL.init(string: imageURL as String)!))!
                if (image != nil) {
                    self.saveImage(image!, path: imagePath)
                    DispatchQueue.main.async {
                        success(image!)
                    }
                }
            }
        }
    }
    
    func setMaskToView(view: UIView, byRoundingCorners corners: UIRectCorner) {
        let radius: CGFloat = view.frame.size.width / 2
        let rounded : UIBezierPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape: CAShapeLayer = CAShapeLayer.init()
        shape.path = rounded.cgPath
        view.layer.mask = shape
    }
}
