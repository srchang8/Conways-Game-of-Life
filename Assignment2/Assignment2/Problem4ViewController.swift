//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by stephen chang on 6/28/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

//import Foundation

import UIKit

class Problem4ViewController: UIViewController {
    
    
    //MARK: Properties
    
    @IBOutlet weak var textViewProblem4: UITextView!
    @IBAction func runButtonProblem4(sender: UIButton) {
        
        textViewProblem4.text = " runButtonProblem4 was pressed "
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        self.title = "Problem 4"
        
    }
    
    
}

