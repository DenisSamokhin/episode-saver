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
    let lineWidth: CGFloat! = 2
    var centerPoint: CGPoint!
    
    override init(frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init() {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        centerPoint = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.backgroundColor = UIColor.clear
        startAngle = 0 - self.radiansFromDegrees(degrees: 90);
        endAngle = startAngle + CGFloat(M_PI) * 2;
        if radius <= 0 {
            radius = (rect.size.width - lineWidth * 2) / 2
        }
        if progress < 0 {
            progress = 0;
        }else if progress > 10 {
            progress = 10
        }
        drawText(rect: rect)
        self.drawBackgroundLine(rect: rect)
        self.drawLine(rect: rect)
    }
    
    func drawLine(rect: CGRect) {
        let arc: CAShapeLayer = CAShapeLayer()
        let lastPosition: CGFloat = (endAngle - startAngle) * (progress / 10) + startAngle
        arc.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: lastPosition, clockwise: true).cgPath
        arc.lineCap = kCALineCapRound
        arc.fillColor = UIColor.clear.cgColor
        arc.strokeColor = strokeColor.cgColor
        arc.lineWidth = lineWidth
        self.layer.addSublayer(arc)
    }
    
    func drawBackgroundLine(rect: CGRect) {
        let arc: CAShapeLayer = CAShapeLayer()
        let newLineWidth = lineWidth / 2
        arc.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        arc.lineCap = kCALineCapRound
        arc.fillColor = UIColor.clear.cgColor
        arc.strokeColor = strokeColor.withAlphaComponent(0.1).cgColor
        arc.lineWidth = newLineWidth
        self.layer.addSublayer(arc)
    }
    
    func drawText(rect: CGRect) {
        for var subview: UIView in self.subviews {
            subview.removeFromSuperview()
        }
        let textLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textLabel.center = centerPoint
        textLabel.backgroundColor = UIColor.clear
        textLabel.text = "\(progress!)"
        textLabel.textAlignment = .center
        textLabel.font = textLabel.font.withSize(13)
        self.addSubview(textLabel)
    }
    
    func radiansFromDegrees(degrees: CGFloat) -> CGFloat {
        return degrees * 0.017453292519943
    }
    
}
