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
    
    
    
    @IBOutlet weak var textViewProblem2: UITextView!
    
    @IBAction func runButtonProblem2(sender: UIButton) {
        
    textViewProblem2.text = "Run Button Pressed"
        
        
        
        //constant variable in case we want to change the size of game of life grid
        let NumColumns: Int = 10
        let NumRows: Int = 10
        
        var numOfLivingCellsInBefore: Int = 0
        var numOfLivingCellsInAfter: Int = 0
        
        
        //create an array of type bool
        var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        //create second array to track first array
        var after = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        
        
        //check if the cell is dead given the coordinate
        func checkCoordinates( x: Int, y: Int) -> Bool{
            
            var checkedX: Int = x
            var checkedY: Int = y
            
            
            //check if coordinates are out of bounds
            // when out of bounds is -1 or = size of array,
            //it will convert to size -1 to be able to check other side of array
            if x < 0 {
                checkedX = NumColumns - 1
            }
            
            if x >= NumColumns {
                checkedX = NumColumns - 1
                
            }
            
            if y < 0 {
                checkedY = NumRows - 1
            }
            
            if y >= NumRows {
                checkedY = NumRows - 1
            }
            
            //check if cell is alive
            return before[checkedX][checkedY]
            
        }
        
        
        //check the neighbors around the cell to see if alive
        func checkNeighbors(x: Int, y: Int) -> Bool {
            
            
            var aliveCount: Int = 0
            var alive: Bool = false
            
            //check top left
            if checkCoordinates( x-1, y: y-1 ) {
                aliveCount+=1
            }
    
            //check top
            if checkCoordinates( x, y: y-1 ){
                aliveCount+=1
            }
            
            //check top right
            if checkCoordinates( x+1, y: y-1){
                aliveCount+=1
            }
            
            //check right
            if checkCoordinates( x+1, y: y){
                aliveCount+=1
            }
            
            //check bottom right
            if checkCoordinates( x+1, y: y-1){
                
            }
            
            //check bottom
            if checkCoordinates( x, y: y-1){
                aliveCount+=1
            }
            
            //check bottom left
            if checkCoordinates( x-1, y: y-1){
                aliveCount+=1
            }
            
            
            //check to see if current cell is dead or alive first
            switch before[x][y] {
                
            case true:
                if aliveCount == 2 || aliveCount == 3 {
                    alive = true
                }
            
            case false:
                if aliveCount == 3{
                    alive = true
                }
                
            }
            
           
            
            // return if cell given in the parameter should be alive 
            //by checking its neighbors and taking in consideration if the coordinates go out of bounds
            return alive
            
            
        }
        
        
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
        
        
        
        
        
        //Check each cell in before and send result to after
        for y in 0..<NumColumns{//iterate 0-9
            for x in 0..<NumRows{//iterate 0-9
                
                
                if checkNeighbors( x, y: y) == true{
                    after[y][x] = true
                    numOfLivingCellsInAfter+=1
                } else if checkNeighbors( x, y: y) == false{
                    after[y][x] = false
                }
                
                //print(before[y][x]) //print entire array to see if random variables generated correctly
            }
            
        }
        
        
        //count and print number of living cells in After
        textViewProblem2.text="Living cells in Before: \(numOfLivingCellsInBefore) \nLiving cells in After: \(numOfLivingCellsInAfter)"
        
    }
    
   


    
    override func viewDidLoad() {
        
        //P1 #7
        self.title = "Problem 2"// not sure if this works
        
        
        
       
        
        
        
        
        
    }
    
    
}

