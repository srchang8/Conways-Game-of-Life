//
//  Grid.swift
//  Assignment4
//
//  Created by stephen chang on 7/18/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import Foundation


class Grid: GridProtocol {
    private var grid : [CellState]
    
    var rows : Int = 0
    var cols : Int = 0
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = [CellState](count: rows * cols, repeatedValue: CellState.Empty)
    }
    
    
    func neighbors(neighbor: (row : Int, col : Int)) -> [(row : Int, col : Int)] {
        
        //create an array of tuples
        var arrOfNeighborCoordinates:[(row : Int, col : Int)] = []
        
        let NumColumns = 10
        let NumRows = 10
        
        //add the coordinates into the array col of tuples
        let row = neighbor.row
        let col = neighbor.col
        arrOfNeighborCoordinates += [(rowCoord: row-1, colCoord: col-1)]//topLeft
        arrOfNeighborCoordinates += [(rowCoord: row, colCoord: col-1)]//top
        arrOfNeighborCoordinates += [(rowCoord: row+1, colCoord: col-1)]//topRight
        arrOfNeighborCoordinates += [(rowCoord: row+1, colCoord: col)]//right
        arrOfNeighborCoordinates += [(rowCoord: row+1, colCoord: col+1)]//bottomRight
        arrOfNeighborCoordinates += [(rowCoord: row, colCoord: col+1)]//bottom
        arrOfNeighborCoordinates += [(rowCoord: row-1, colCoord: col+1)]//bottomLeft
        arrOfNeighborCoordinates += [(rowCoord: row-1, colCoord: col)]//left
        
        
        //coordinates that go out of bound of the 10x10 array should point back the next available cell
        for i in 0..<arrOfNeighborCoordinates.count{
            
            if arrOfNeighborCoordinates[i].row < 0 {
                arrOfNeighborCoordinates[i].row = NumColumns - 1
            }
            
            if arrOfNeighborCoordinates[i].row >= NumColumns {
                arrOfNeighborCoordinates[i].row = NumColumns - 1
            }
            
            if arrOfNeighborCoordinates[i].col < 0 {
                arrOfNeighborCoordinates[i].col = NumColumns - 1
            }
            
            if arrOfNeighborCoordinates[i].col >= NumRows {
                arrOfNeighborCoordinates[i].col = NumRows - 1
            }
            
            
        }
        
        return arrOfNeighborCoordinates
    }
    
    
    
    
    subscript(row: Int, column: Int) -> CellState {
        get {
            return grid[(row * cols) + column]
        }
        set {
            grid[(row * cols) + column] = newValue
        }
    }
}
