//
//  MGGradientRing.swift
//  MyAnimatingButton
//
//  Created by Maria Gomez on 9/29/15.
//  Copyright © 2015 Maria Gomez. All rights reserved.
//

/*

Abstract:
The `MGGradientRing` creates a gradient ring of two colors
*/

import UIKit

class MGGradientRing: CALayer {
    
    //points for pointing the gradient towards
    fileprivate let startPoints = [
        CGPoint(x: 0,y: 0),
        CGPoint(x: 1,y: 0),
        CGPoint(x: 1,y: 1),
        CGPoint(x: 0,y: 1),
    ]
    
    fileprivate let endPoints = [
        CGPoint(x: 1,y: 1),
        CGPoint(x: 0,y: 1),
        CGPoint(x: 0,y: 0),
        CGPoint(x: 1,y: 0),
    ]
    
    fileprivate var count = 4
    
    
    var fromColor = UIColor.clear
    var toColor = UIColor.clear

    fileprivate var _gradientColors : [CGColor] = []
    fileprivate var gradientColors : [CGColor] {
        get{
            if _gradientColors.count != 0 {return _gradientColors}
            var fromRed : CGFloat = 0.0
            var fromGreen : CGFloat = 0
            var fromBlue : CGFloat = 0
            var fromAlpha: CGFloat = 0
            
            self.fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
            
            var toRed : CGFloat = 0
            var toGreen : CGFloat = 0
            var toBlue : CGFloat = 0
            var toAlpha: CGFloat = 0
            
            self.toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
            
            var gradient : [CGColor] = []
            
            //slice up the colors to make the gradient
            for i in (0...count) {
                
                 gradient.append(UIColor(
                    red: fromRed + (toRed - fromRed)/CGFloat(count) * CGFloat(i),
                    green: fromGreen + (toGreen - fromGreen)/CGFloat(count) * CGFloat(i),
                    blue: fromBlue + (toBlue - fromBlue)/CGFloat(count) * CGFloat(i),
                    alpha: fromAlpha + (toAlpha - fromAlpha)/CGFloat(count) * CGFloat(i)
                    ).cgColor
                )
                
            }
            _gradientColors = gradient
            return gradient
        }
     }
    
    init(fromColor: UIColor, toColor: UIColor, bounds:CGRect, lineWidth:CGFloat) {
        
        
        //this init will create four gradient boxes in four different position with their own distinct direction
        //all are added as a layer and then a circle is used for the mask
        let width = bounds.width/CGFloat(count)
        let height = bounds.height/CGFloat(count)
        var positionWithBounds :[CGPoint] = [
            CGPoint(x: width * 3.0, y: height * 1.0),
            CGPoint(x: width * 3.0, y: height * 3.0),
            CGPoint(x: width * 1.0, y: height * 3.0),
            CGPoint(x: width * 1.0, y: height * 3.0),
       ]
        
        //to create gradient get both colors and divide up into slices to get an array of colors for each slice
        self.fromColor = fromColor
        self.toColor = toColor

        super.init()
        
        self.bounds = bounds
        self.borderWidth = lineWidth
        self.borderColor = UIColor.clear.cgColor
        
        //create four gradient layers each facing to a different corner of the frame going clockwise
        for i in (0...(count-1)) {
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.bounds = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.width/2)
            gradientLayer.position = positionWithBounds[i]

            gradientLayer.colors = [gradientColors[i], gradientColors[i+1]]
            
            gradientLayer.locations = [NSNumber(value: 0.0 as Float), NSNumber(value: 1.0 as Float)]
            gradientLayer.startPoint = startPoints[i]
            gradientLayer.endPoint = endPoints[i]
            self.addSublayer(gradientLayer)

        }
        
    
        //add the mask for the circle
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0,width: bounds.size.width - 2 * borderWidth, height: bounds.size.height - 2 * borderWidth)
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.bounds, cornerRadius: shapeLayer.bounds.width).cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.strokeStart = 0.05
        shapeLayer.strokeEnd = 0.970
        
        self.mask = shapeLayer
     }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
