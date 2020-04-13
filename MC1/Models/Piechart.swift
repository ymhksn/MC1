//
//  Piechart.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 13/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit

//MARK: - Pie Chart UIBezierPath
class Piechart: UIView {
    var path: UIBezierPath!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        // define data to create pie chart
        let data: [Int] = [30, 15, 5, 17, 3, 10, 20]
        
        //Make a circle with center point
        // 1. find center of draw rect
        let center: CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        // 2. calculate corner radius of pie (make it circle)
        let radius = min(rect.width, rect.height) / 2.0
        
        //Looping data through an array
        var startAngle: CGFloat = 0.0
        for value in data {
            
            // 3. calculate end angle for slice
            let endAngle = CGFloat(value) / 100.0 * CGFloat.pi * 2.0 + startAngle
            
            // 4. create UIBezierPath for slide
            let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            // 5. add line to center to close path so it make pizza slice
            circlePath.addLine(to: center)
            
            // 6. set fill color for current slice
            UIColor(red: (CGFloat(arc4random_uniform(256)) / 255.0), green: (CGFloat(arc4random_uniform(256)) / 255.0), blue: (CGFloat(arc4random_uniform(256)) / 255.0), alpha: 1.0).setFill()
            
            // 7. fill slice path
            circlePath.fill()
            
            // 8. set end angle as start angle for next slice
            startAngle = endAngle
        }
    }
}
