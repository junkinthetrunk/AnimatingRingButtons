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
        button.setImage(UIImage(named: "Bulb"), for: UIControlState())
        button.setTitle("", for: UIControlState())
        
        button2.setImage(UIImage(named: "Bulb"), for: UIControlState())
        button2.setTitle("", for: UIControlState())
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(_ sender: AnimatingButton) {
        
        sender.animate = !sender.animate
        
    }

    @IBAction func buttonClicked(_ sender: AnimatingButton2) {
        
        sender.animate = !sender.animate
       
    }
 }

