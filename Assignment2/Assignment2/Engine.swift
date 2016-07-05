//
//  Engine.swift
//  Assignment2
//
//  Created by stephen chang on 7/4/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import Foundation

func step(twoDimArrOfBools: Array<Array<Bool>> ) -> Array<Array<Bool>> {
    
    var NumColumns = twoDimArrOfBools.count
    var NumRows = twoDimArrOfBools.count
    var numOfLivingCellsInBefore: Int = 0
    var numOfLivingCellsInAfter: Int = 0
    
    var after = Array(count:twoDimArrOfBools.count, repeatedValue: Array(count:twoDimArrOfBools.count, repeatedValue:false))
    
    
    
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
        return twoDimArrOfBools[checkedX][checkedY]
        
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
        switch twoDimArrOfBools[x][y] {
            
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
    
    
    
    //Check each cell in before and send result to after
    for y in 0..<NumColumns{
        for x in 0..<NumRows{
            
            if checkNeighbors( x, y: y) == true{
                after[y][x] = true
                numOfLivingCellsInAfter+=1
            } else if checkNeighbors( x, y: y) == false{
                after[y][x] = false
            }
        }
        
    }
    

    
    return after
}





