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


    @IBInspectable var rows: Int = 20
    @IBInspectable var cols: Int = 20
    
    @IBInspectable var livingColor: UIColor = UIColor()
    @IBInspectable var EmptyColor: UIColor = UIColor()
    @IBInspectable var bornColor: UIColor = UIColor()
    @IBInspectable var diedColor: UIColor = UIColor()
    
    @IBInspectable var gridColor: CGColor!
    
    @IBInspectable var gridWidth: CGFloat = 0
    

    
    //a 2D array of CellState values called grid which reinitialize to all .Empty vales every time rows or cols changes using didSet keyword on the rows ancols values
    
    var grid = Array(count:20, repeatedValue: Array(count:20, repeatedValue: CellState.Empty))
    

    
    
    
    override func drawRect(rect: CGRect)
    {
        var countRows: Int = 0
        var countColumns: Int = 0
        let xStart: CGFloat = 50//start position for x coordinate
        let yStart: CGFloat = 50// start position for y coordinate
        
        
        
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
        
        
        
        //Draw Circles
        
        //put into function
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(70, 70, 10, 10))
        var ovalPath1 = UIBezierPath(ovalInRect: CGRectMake(100, 100, 10, 10))
        UIColor.grayColor().setFill()
        
        //var ovalPath1 = UIBezierPath(ovalInRect: CGRectMake(50, 50, 5, 5))
        
        ovalPath1.fill()
        ovalPath.fill()
        
    }//override rect function closing bracket
        
        
    func fillCell(var xCoord: CGFloat, var yCoord: CGFloat){
        
    }
    
    
    
    
    /*
 draws a circle inside of every grid cell and fills the circle with the appropriate color for the grid cell 
     drawn from the grid array.  
     
     e.g. for grid cell (0,0) fetch the zero'th array from grid and then fetch the CellState value from the zero'th position of the array and color the circle using the color specified in IB. Repeat for the other values
 */
    
    
    
    
    //MARK: functions
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




