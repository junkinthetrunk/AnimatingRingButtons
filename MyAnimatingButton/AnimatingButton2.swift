//
//  ZNPowerButton2.swift
//  MyAnimatingButton
//
//  Created by Maria Gomez on 9/29/15.
//  Copyright © 2015 Maria Gomez. All rights reserved.
//

import UIKit


@IBDesignable class AnimatingButton2 : UIButton {
    
    
    // MARK: Properties
    
    @IBInspectable var fromColor: UIColor = UIColor.whiteColor()
    @IBInspectable var toColor :UIColor = UIColor.purpleColor()

    @IBInspectable var borderWidth :CGFloat = 2.0
    
    private var _animatingRing :CALayer?
    private var animatingRing : CALayer? {
        get {
            
            if  _animatingRing != nil {return _animatingRing}
         
            self.backgroundColor = UIColor.clearColor()
            
            let animatingLayer = MGGradientRing(fromColor:self.fromColor, toColor: self.toColor, bounds: self.bounds, lineWidth:borderWidth)
            
            animatingLayer.frame = self.bounds
            
            _animatingRing = animatingLayer
            animatingLayer.hidden = true
            return animatingLayer
        }
        
    }
    
    var animate : Bool = false {
        didSet {
            if (animate) {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotationAnimation.toValue = CGFloat (M_PI * 2.0)
                rotationAnimation.duration = 0.75
                rotationAnimation.cumulative = true
                rotationAnimation.repeatCount = HUGE
                
                animatingRing!.addAnimation(rotationAnimation, forKey: "rotationAnimation")
                animatingRing!.hidden = false
            }
            else {
                animatingRing!.removeAllAnimations()
                animatingRing!.hidden = true
            }
            
        }
    }
    
    var isAnimating : Bool {
        get {
            return animate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(animatingRing!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.addSublayer(animatingRing!)
    }
    
    
}
