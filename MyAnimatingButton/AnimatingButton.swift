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
        
    fileprivate let borderWidth :CGFloat = 2.0
    
    @IBInspectable var ringColor: UIColor = UIColor.white
    @IBInspectable var strokeColor :UIColor = UIColor.purple
    
    fileprivate var _animatingRing :UIView?
    fileprivate var animatingRing : UIView? {
        get {
            
            if  _animatingRing != nil {return _animatingRing}
            
            let ring = UIView(frame: self.bounds)
            
            ring.isHidden = true
            ring.backgroundColor = UIColor.clear
            
            let animatingLayer = CAShapeLayer()
            let ringRect = self.bounds.insetBy(dx: borderWidth/2, dy: borderWidth/2)
            
            animatingLayer.path = UIBezierPath(roundedRect: ringRect, cornerRadius: min(ringRect.height, ringRect.width)/2).cgPath
            animatingLayer.lineWidth = borderWidth + 0.5
            animatingLayer.lineCap = "round"
            animatingLayer.strokeEnd = 0.025
            animatingLayer.strokeColor = strokeColor.cgColor
            animatingLayer.fillColor = UIColor.clear.cgColor
            
            let ringLayer = CAShapeLayer()
            ringLayer.path = UIBezierPath(roundedRect: ringRect, cornerRadius: min(ringRect.height, ringRect.width)/2).cgPath
            ringLayer.lineWidth = self.borderWidth + 0.5;
            ringLayer.strokeColor = ringColor.cgColor;
            ringLayer.fillColor = UIColor.clear.cgColor;
            
            ringLayer.addSublayer(animatingLayer)
            ring.layer.addSublayer(ringLayer)
            
            _animatingRing = ring
            ring.isUserInteractionEnabled = false
            return ring
        }
        
    }
    
    var animate : Bool = false {
        didSet {
            if (animate) {
                let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotationAnimation.toValue = CGFloat (Double.pi * 2.0)
                rotationAnimation.duration = 0.75
                rotationAnimation.isCumulative = true
                rotationAnimation.repeatCount = HUGE
                
                animatingRing!.layer.add(rotationAnimation, forKey: "rotationAnimation")
                animatingRing!.isHidden = false
            }
            else {
                animatingRing!.layer .removeAllAnimations()
                animatingRing!.isHidden = true
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
