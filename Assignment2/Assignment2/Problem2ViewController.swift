//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by stephen chang on 6/28/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

//import Foundation


import UIKit

class Problem2ViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var textViewProblem2: UITextView!
    
    @IBAction func runButtonProblem2(sender: UIButton) {
        
        textViewProblem2.text = "Run Button Pressed"
        
    }
    
   


    
    override func viewDidLoad() {
        
        //P1 #7
        self.title = "Problem 2"// not sure if this works
        
        
    }
    
    
}

