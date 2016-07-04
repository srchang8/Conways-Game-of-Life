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
        
        let NumColumns: Int = 10
        let NumRows: Int = 10
        var numOfLivingCellsInBefore: Int = 0
        var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        var afterStep = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        
        //set a random true or false value for each cell in the before array
        for y in 0..<NumColumns{//iterate 0-9
            for x in 0..<NumRows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    before[y][x] = true
                    numOfLivingCellsInBefore+=1
                    
                }
                //print(before[y][x]) //print entire array to see if random variables generated correctly
            }
            
        }

        
       afterStep = step(before)
        
        textViewProblem3.text="Run button pressed \nLiving cells in Before: \(numOfLivingCellsInBefore) \nLiving cells in After: \(afterStep.getNumOfLivingCells())"
        
        
        
    }
    
    override func viewDidLoad() {
        
        self.title = "Problem 3"
        
    }
    
    
}

