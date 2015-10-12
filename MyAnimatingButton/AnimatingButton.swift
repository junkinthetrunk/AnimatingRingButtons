//
//  AnimatingButton.swift
//  MyAnimatingButton
//
//  Created by Maria Gomez on 9/28/15.
//  Copyright © 2015 Maria Gomez. All rights reserved.
//
import UIKit



@IBDesignable class AnimatingButton : UIButton {
    
    
    // MARK: Properties
        
    private let borderWidth :CGFloat = 2.0
    
    @IBInspectable var ringColor: UIColor = UIColor.whiteColor()
    @IBInspectable var strokeColor :UIColor = UIColor.purpleColor()
    
    private var _animatingRing :UIView?
    private var animatingRing : UIView? {
        get {
            
            if  _animatingRing != nil {return _animatingRing}
            
            let ring = UIView(frame: self.bounds)
            
            ring.hidden = true
            ring.backgroundColor = UIColor.clearColor()
            
            let animatingLayer = CAShapeLayer()
            let ringRect = CGRectInset(self.bounds, borderWidth/2, borderWidth/2)
            
            animatingLayer.path = UIBezierPath(roundedRect: ringRect, cornerRadius: min(CGRectGetHeight(ringRect), CGRectGetWidth(ringRect))/2).CGPath
            animatingLayer.lineWidth = borderWidth + 0.5
            animatingLayer.lineCap = "round"
            animatingLayer.strokeEnd = 0.025
            animatingLayer.strokeColor = strokeColor.CGColor
            animatingLayer.fillColor = UIColor.clearColor().CGColor
            
            let ringLayer = CAShapeLayer()
            ringLayer.path = UIBezierPath(roundedRect: ringRect, cornerRadius: min(CGRectGetHeight(ringRect), CGRectGetWidth(ringRect))/2).CGPath
            ringLayer.lineWidth = self.borderWidth + 0.5;
            ringLayer.strokeColor = ringColor.CGColor;
            ringLayer.fillColor = UIColor.clearColor().CGColor;
            
            ringLayer.addSublayer(animatingLayer)
            ring.layer.addSublayer(ringLayer)
            
            _animatingRing = ring
            ring.userInteractionEnabled = false
            return ring
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
                
                animatingRing!.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
                animatingRing!.hidden = false
            }
            else {
                animatingRing!.layer .removeAllAnimations()
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
        self.addSubview(animatingRing!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(animatingRing!)
    }

}
