//
//  StandardEngine.swift
//  Assignment4
//
//  Created by stephen chang on 7/18/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import Foundation


class StandardEngine: EngineProtocol {
    static var sharedInstance = StandardEngine(rows: 10, cols: 10)
    
    var delegate : EngineDelegate?
    var grid : GridProtocol {
        didSet {
            self.rows = self.grid.rows
            self.cols = self.grid.rows
            self.delegate?.engineDidUpdate(self.grid)
            NSNotificationCenter.defaultCenter().postNotificationName(EngineDidUpdateGridNotificationName, object: nil, userInfo: ["grid" : self.grid])
        }
    }
    var refreshRate : Double = 0.1 {
        didSet {
            self.scheduleTimer()
        }
    }
    var refreshTimer : NSTimer = NSTimer()
    var rows : Int
    var cols : Int
    
    func scheduleTimer() {
        if PersistenceService.sharedInstance.timedRefresh {
            let interval = 1.0 / self.refreshRate
            self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: #selector(StandardEngine.timerFired), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerFired() {
        self.step()
    }
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = rows
        self.grid = Grid(rows: rows, cols: cols)
        self.scheduleTimer()
    }
    
    
    func step() -> GridProtocol {
        
        let NumColumns = self.rows
        let NumRows = self.cols
        var numOfLivingCellsInAfter: Int = 0
        
        let after = Grid(rows: NumRows, cols: NumColumns)
        
        
        
        
        //Check each cell in before and send result to after
        for y in 0..<NumColumns{
            for x in 0..<NumRows{
                
                if checkNeighbors( x, y: y) == true{
                    after[y, x] = .Living
                    numOfLivingCellsInAfter+=1
                    
                    
                } else if checkNeighbors( x, y: y) == false{
                    after[y, x] = .Died
                }
            }
        }
        
        self.grid = after
        
        return after//return for step() function
    }
    
    
    //check if the cell is dead given the coordinate
    func checkCoordinates( x: Int, y: Int) -> Bool {
        
        var checkedX: Int = x
        var checkedY: Int = y
        
        
        //check if coordinates are out of bounds
        // when out of bounds is -1 or = size of array,
        //it will convert to size -1 to be able to check other side of array
        if x < 0 {
            checkedX = self.cols - 1
        }
        
        if x >= self.cols {
            checkedX = self.cols - 1
            
        }
        
        if y < 0 {
            checkedY = self.rows - 1
        }
        
        if y >= self.rows {
            checkedY = self.rows - 1
        }
        
        //check if cell is alive
        switch self.grid[checkedX, checkedY] {
        case .Living, .Born:
            return true
        case .Empty, .Died:
            return false
        }
    }
    
    //check the neighbors around the cell to see if alive, returns either alive or dead
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
            aliveCount+=1
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
        switch self.grid[x, y] {
            
        //if it is alive and it has 2 or 3 alive neighbors
        case .Living, .Born:
            if aliveCount == 2 || aliveCount == 3 {
                alive = true
            }
            
        //if it is dead and has 3 alive neighbors
        case .Empty, .Died:
            if aliveCount == 3{
                alive = true
            }
            
        }
        
        
        // return if cell given in the parameter should be alive
        //by checking its neighbors and taking in consideration if the coordinates go out of bounds
        return alive
        
        
    }
}

