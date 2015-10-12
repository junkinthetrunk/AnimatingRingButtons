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
    private let startPoints = [
        CGPointMake(0,0),
        CGPointMake(1,0),
        CGPointMake(1,1),
        CGPointMake(0,1),
    ]
    
    private let endPoints = [
        CGPointMake(1,1),
        CGPointMake(0,1),
        CGPointMake(0,0),
        CGPointMake(1,0),
    ]
    
    private var count = 4
    
    
    var fromColor = UIColor.clearColor()
    var toColor = UIColor.clearColor()

    private var _gradientColors : [CGColor] = []
    private var gradientColors : [CGColor] {
        get{
            if _gradientColors.count != 0 {return _gradientColors}
            var fromRed : CGFloat = 0
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
            for var i = 0; i <= count; i++ {
                
                 gradient.append(UIColor(
                    red: fromRed + (toRed - fromRed)/CGFloat(count) * CGFloat(i),
                    green: fromGreen + (toGreen - fromGreen)/CGFloat(count) * CGFloat(i),
                    blue: fromBlue + (toBlue - fromBlue)/CGFloat(count) * CGFloat(i),
                    alpha: fromAlpha + (toAlpha - fromAlpha)/CGFloat(count) * CGFloat(i)
                    ).CGColor
                )
                
            }
            _gradientColors = gradient
            return gradient
        }
     }
    
    init(fromColor: UIColor, toColor: UIColor, bounds:CGRect, lineWidth:CGFloat) {
        
        
        //this init will create four gradient boxes in four different position with their own distinct direction
        //all are added as a layer and then a circle is used for the mask
        var positionWithBounds :[CGPoint] = [
            CGPointMake(CGRectGetWidth(bounds)/CGFloat(count) * CGFloat(3), CGRectGetHeight(bounds)/CGFloat(count) * CGFloat(1)),
            CGPointMake(CGRectGetWidth(bounds)/CGFloat(count) * CGFloat(3), CGRectGetHeight(bounds)/CGFloat(count) * CGFloat(3)),
            CGPointMake(CGRectGetWidth(bounds)/CGFloat(count) * CGFloat(1), CGRectGetHeight(bounds)/CGFloat(count) * CGFloat(3)),
            CGPointMake(CGRectGetWidth(bounds)/CGFloat(count) * CGFloat(1), CGRectGetHeight(bounds)/CGFloat(count) * CGFloat(1)),
       ]
        
        //to create gradient get both colors and divide up into slices to get an array of colors for each slice
        self.fromColor = fromColor
        self.toColor = toColor

        super.init()
        
        self.bounds = bounds
        self.borderWidth = lineWidth
        self.borderColor = UIColor.clearColor().CGColor
        
        //create four gradient layers each facing to a different corner of the frame going clockwise
        for var i = 0; i <= count - 1 ; i++ {
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds)/2, CGRectGetWidth(bounds)/2)
            gradientLayer.position = positionWithBounds[i]

            gradientLayer.colors = [gradientColors[i], gradientColors[i+1]]
            
            gradientLayer.locations = [NSNumber(float: 0.0), NSNumber(float: 1.0)]
            gradientLayer.startPoint = startPoints[i]
            gradientLayer.endPoint = endPoints[i]
            self.addSublayer(gradientLayer)

        }
        
    
        //add the mask for the circle
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRectMake(0, 0,bounds.size.width - 2 * borderWidth, bounds.size.height - 2 * borderWidth)
        shapeLayer.position = CGPointMake(CGRectGetWidth(bounds)/2, CGRectGetHeight(bounds)/2)
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.bounds, cornerRadius: CGRectGetWidth(shapeLayer.bounds)).CGPath
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