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
        
        //Create 2 dimensional array of type bool - name it "before"
        
    }
    
   


    
    override func viewDidLoad() {
        
        //P1 #7
        self.title = "Problem 2"// not sure if this works
        
        
        //test
        
        //constant variable in case we want to change the size of game of life grid
        let NumColumns = 10
        let NumRows = 10
        
        //create an array of type bool
        var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        //create second array to track first array
        var after = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        
        //set a random true or false value for each cell in the before array
        for y in 0..<NumColumns{//iterate 0-9
            for x in 0..<NumRows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    before[y][x] = true
                    
                }
                print(before[y][x]) //print entire array to see if random variables generated correctly
            }
            
        }
        
        
        
        
        //test end
        
        
    }
    
    
}

