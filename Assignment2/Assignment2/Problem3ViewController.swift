//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by stephen chang on 6/28/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

//import Foundation

import UIKit

class Problem3ViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var textViewProblem3: UITextView!
    
    @IBAction func runButtonProblem3(sender: UIButton) {
        textViewProblem3.text = "runButtonProblem 3 pressed "
    }
    
    override func viewDidLoad() {
        
        self.title = "Problem 3"
        
    }
    
    
}

