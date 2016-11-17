//
//  DSCircularProgressBar.swift
//  Episode Saver
//
//  Created by Denis on 17.11.16.
//  Copyright © 2016 ITLions. All rights reserved.
//

import Foundation
import UIKit

class DSCircularProgressBar: UIView {
    
    var radius: CGFloat!
    var progress: CGFloat!
    var strokeColor: UIColor!
    var startAngle: CGFloat!
    var endAngle: CGFloat!
    let lineWidth: CGFloat! = 6.0
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.white
        self.progress = 0
        self.radius = 0
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func draw(_ rect: CGRect) {
        startAngle = 0 - self.radiansFromDegrees(degrees: 90);
        endAngle = startAngle + CGFloat(M_PI) * 2;
        if progress < 0 {
            progress = 0;
        }else if progress > 10 {
            progress = 10
        }
        self.draw(rect)
    }
    
    func drawLine(rect: CGRect) {
        let centerPoint: CGPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let arc: CAShapeLayer = CAShapeLayer()
        let lastPosition: CGFloat = (endAngle - startAngle) * (progress)
        arc.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: lastPosition, clockwise: true).cgPath
        arc.lineCap = kCALineCapRound
        arc.fillColor = UIColor.clear.cgColor
        arc.strokeColor = strokeColor.cgColor
        arc.lineWidth = lineWidth
        self.layer.addSublayer(arc)
    }
    
    func radiansFromDegrees(degrees: CGFloat) -> CGFloat {
        return degrees * 0.017453292519943
    }
    
}
