//
//  ViewController.swift
//  MyAnimatingButton
//
//  Created by Maria Gomez on 9/28/15.
//  Copyright © 2015 Maria Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: AnimatingButton!
    
    @IBOutlet weak var button2: AnimatingButton2!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(UIImage(named: "Bulb"), forState: .Normal)
        button.setTitle("", forState: .Normal)
        
        button2.setImage(UIImage(named: "Bulb"), forState: .Normal)
        button2.setTitle("", forState: .Normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnimatingButton) {
        
        sender.animate = !sender.animate
        
    }

    @IBAction func buttonClicked(sender: AnimatingButton2) {
        
        sender.animate = !sender.animate
       
    }
 }

