//
//  GridView.swift
//  Assignment3
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import UIKit


@IBDesignable//Let interface builder know that it should render the view directly in the canvas. Allows seeing how your custom views will appear without building and running your app after each change
class GridView: UIView {


    @IBInspectable var rows: Int = 20 {
        didSet {
            print("rows has changed, grid array will all be set to empty")
        }
    }
    
    @IBInspectable var cols: Int = 20 {
        didSet {
            print("cols has changed, grid array will all be set to empty")
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor()
    @IBInspectable var emptyColor: UIColor = UIColor()
    @IBInspectable var bornColor: UIColor = UIColor()
    @IBInspectable var diedColor: UIColor = UIColor()
    
    @IBInspectable var gridColor: CGColor!
    
    @IBInspectable var gridWidth: CGFloat = 0
    

    
    //a 2D array of CellState values called grid which reinitialize to all .Empty values every time rows or cols changes using didSet keyword on the rows and cols values
    
    var grid = Array(count:20, repeatedValue: Array(count:20, repeatedValue: CellState.Empty))
    
    
    let xStart: CGFloat = 50//start position for x coordinate
    let yStart: CGFloat = 50// start position for y coordinate
    
    
    
    override func drawRect(rect: CGRect)
    {
        var countRows: Int = 0
        var countColumns: Int = 0
        
        
        
        
        //20x20 going
        //cell size 10x10
        
        
        //Draw rows
        for var y: CGFloat = yStart; y <= 250; y+=10
        {
            
            drawRowLine(xStart, yCoord: y)
            
            countRows+=1

            
            if countRows > rows
            {
                print("For Loop cannot run more than number of rows designated")
                print("number of rows before break \(countRows)")
                break
            }
            
        
        }
            //print("number of rows \(countRows)")
        
        
        
        //draw columns
        for var x: CGFloat = xStart; x <= 250; x+=10
        {
            
            drawColumnLine(x, yCoord: yStart)
            
            countColumns+=1
            
            
            if countColumns > cols
            {
                print("For Loop cannot run more than number of columns designated")
                print("number of columns before break \(countColumns)")
                break
            }
            
            
        }
            //print("number of columns \(countRows)")
        
        
        
        //Draw Circles on all the cells
        
        for y in 0..<cols{
            for x in 0..<rows{
                
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
            }
        }
       // fillCell(19, yCoord: 19)
        
        
        
    }//override rect function closing bracket
    
    
    
    
    //MARK: functions
    //takes coordinates and fills the the respective cell
    func fillCell(var xCoord: CGFloat, var yCoord: CGFloat){
        
        //cast CGFloat to int
        var xCoordInt = Int(xCoord)
        var yCoordInt = Int(yCoord)
        
        //print("test \(grid[xCoordInt][yCoordInt])")
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        xCoord = xCoord*10 + xStart
        yCoord = yCoord*10 + yStart
        
        //var myIntValue = Int(myFloatValue)

        
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoord, yCoord, 10, 10))
        
        
        if toggle(grid[xCoordInt][yCoordInt]) == .Living {
            livingColor.setFill()
        }
        
        if toggle(grid[xCoordInt][yCoordInt]) == .Empty {
            emptyColor.setFill()
        }
        
        //fill the circle
        circlePath.fill()
        
    }
    
    
    
    
    //function that takes in coordinates and draws a horizontal line
    func drawRowLine(var xCoord: CGFloat, var yCoord: CGFloat)
    {
        
        let rowContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(rowContext, 1)
        CGContextSetStrokeColorWithColor(rowContext, gridColor)
        
        //MARK: make row lines longer - this sets the grid width?
        let lengthOfLine: CGFloat = 200
        
        CGContextMoveToPoint(rowContext, xCoord, yCoord)//start here
        
        xCoord = xCoord + lengthOfLine//move right
        
        CGContextAddLineToPoint(rowContext, xCoord, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(rowContext)
        
    }

    
    
    //takes in coordinates and draws vertical line
    func drawColumnLine( var xCoord: CGFloat, var yCoord: CGFloat)
    {
        let columnContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(columnContext, 1)
        CGContextSetStrokeColorWithColor(columnContext, gridColor)
        
        //MARK: makes columns longer
        let lengthOfLine: CGFloat = 200
        
        CGContextMoveToPoint(columnContext, xCoord, yCoord)//start here
        
        yCoord = yCoord + lengthOfLine//move down
        
        CGContextAddLineToPoint(columnContext, xCoord, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(columnContext)

    }
    
}




