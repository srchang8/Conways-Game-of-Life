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
        if checkCoordinates( x+1, y: y+1){
            
        }
        
        //check bottom
        if checkCoordinates( x, y: y+1){
            aliveCount+=1
        }
        
        //check bottom left
        if checkCoordinates( x-1, y: y+1){
            aliveCount+=1
        }
        
        //check left
        if checkCoordinates( x-1, y: y){
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





//=============================================================================================================
//Problem 4 starts here



//takes in coordinates and spits out an array of tuples containing all the neighboring cells
func neighbors(x: Int, y: Int) -> Array<(xCoord: Int, yCoord: Int)>{
    
    
    //create an array of tuples
    var arrOfNeighborCoordinates:[(xCoord: Int, yCoord: Int)] = []
    
    let NumColumns = 10
    let NumRows = 10
    
    //add the coordinates into the array of tuples
    arrOfNeighborCoordinates += [(xCoord: x-1, yCoord: y-1)]//topLeft
    arrOfNeighborCoordinates += [(xCoord: x, yCoord: y-1)]//top
    arrOfNeighborCoordinates += [(xCoord: x+1, yCoord: y-1)]//topRight
    arrOfNeighborCoordinates += [(xCoord: x+1, yCoord: y)]//right
    arrOfNeighborCoordinates += [(xCoord: x+1, yCoord: y+1)]//bottomRight
    arrOfNeighborCoordinates += [(xCoord: x, yCoord: y+1)]//bottom
    arrOfNeighborCoordinates += [(xCoord: x-1, yCoord: y+1)]//bottomLeft
    arrOfNeighborCoordinates += [(xCoord: x-1, yCoord: y)]//left
    
    
    //coordinates that go out of bound of the 10x10 array should point back the next available cell
    for i in 0..<arrOfNeighborCoordinates.count{
        
        if arrOfNeighborCoordinates[i].xCoord < 0 {
            arrOfNeighborCoordinates[i].xCoord = NumColumns - 1
        }
        
        if arrOfNeighborCoordinates[i].xCoord >= NumColumns {
            arrOfNeighborCoordinates[i].xCoord = NumColumns - 1
        }
        
        if arrOfNeighborCoordinates[i].yCoord < 0 {
            arrOfNeighborCoordinates[i].yCoord = NumColumns - 1
        }
        
        if arrOfNeighborCoordinates[i].yCoord >= NumRows {
            arrOfNeighborCoordinates[i].yCoord = NumRows - 1
        }
        
        
    }
    
    //print("array[0] is  \(arrOfNeighborCoordinates[0])")
    
    return arrOfNeighborCoordinates
}





func step2(twoDimArrOfBools: Array<Array<Bool>> ) -> Array<Array<Bool>>{
    
    var numOfLivingCellsInBefore: Int = 0
    var numOfLivingCellsInAfter: Int = 0
    var livingNeighborCells: Int = 0
    
    
    //array to hold the updated value for cells
    var after = Array(count:twoDimArrOfBools.count, repeatedValue: Array(count:twoDimArrOfBools.count, repeatedValue:false))
    
    for i in 0..<twoDimArrOfBools.count{
        for j in 0..<twoDimArrOfBools.count{//i and j traverse through 10x10
            
            for k in 0..<twoDimArrOfBools.count{// k traverses through all the neighbors that are stored in the array of tuples

                //check the list of neighbors from twoDimArrOfBools[i][j]
                if twoDimArrOfBools[neighbors(i, y: j)[i].xCoord][neighbors(i, y: j)[i].yCoord] == true{
                    livingNeighborCells+=1
                    
                }
                
            }
            
            switch twoDimArrOfBools[i][j]{
            case true:
                if livingNeighborCells == 3 || livingNeighborCells == 2{
                    after[i][j] = true
                    numOfLivingCellsInAfter += 1
                    livingNeighborCells = 0
                }
            case false:
                if livingNeighborCells == 3{
                    after[i][j] = true
                    numOfLivingCellsInAfter += 1
                }
            }

        }
        
    }
    
   
    
    
    
    return after
}











