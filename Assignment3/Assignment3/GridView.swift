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
    
    var grid = Array(count:2, repeatedValue: Array(count:2, repeatedValue: CellState.Empty))
    

    
    
    
    override func drawRect(rect: CGRect)
    {
        var countRows: Int = 0
        var countColumns: Int = 0
        let xStart: CGFloat = 50//start position for x coordinate
        let yStart: CGFloat = 50// start position for y coordinate
        
        
        
        drawRowLine(xStart, yCoord: yStart)
        
        
        var xTest: CGFloat
        var yTest: CGFloat
        
        
        
        
        //Draw row lines
        //loop creates 20 horizontal lines starting at (30,30)
        //y+(20rows * 10(height between lines) because we want 20 rows
        for var y: CGFloat = yStart; y < 200; y+=10
        {
            
            drawRowLine(xStart, yCoord: y)
            
            countRows+=1

            
            if countRows == rows
            {
                print("For Loop cannot run more than number of rows designated")
                print("number of rows before break \(countRows)")
                //break
            }
            
        
        }
 
        print("number of rows \(countRows)")
        
        
        
        //draw column lines
        for var x: CGFloat = xStart; x < 200; x+=10
        {
            
            drawColumnLine(x, yCoord: yStart)
            
            countColumns+=1
            
            
            if countRows == cols
            {
                print("For Loop cannot run more than number of rows designated")
                print("number of columns before break \(countColumns)")
                //break
            }
            
            
        }
        
        print("number of columns \(countRows)")
        
    }
        
        
    
    
    
    
    
    
    
    
    
    
    //MARK: functions
    //function that takes in coordinates and draws a line from that
    func drawRowLine(var xCoord: CGFloat, var yCoord: CGFloat)
    {
        
        let rowContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(rowContext, 1)
        CGContextSetStrokeColorWithColor(rowContext, gridColor)
        
        //MARK: make lines longer change lengthOfLine - this sets the grid width
        let lengthOfLine: CGFloat = 150
        
        CGContextMoveToPoint(rowContext, xCoord, yCoord)//start here
        
        xCoord = xCoord + lengthOfLine//move right
        
        CGContextAddLineToPoint(rowContext, xCoord, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(rowContext)
        
    }

    
    
    
    func drawColumnLine( var xCoord: CGFloat, var yCoord: CGFloat)
    {
        let columnContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(columnContext, 1)
        CGContextSetStrokeColorWithColor(columnContext, gridColor)
        
        let lengthOfLine: CGFloat = 150
        
        CGContextMoveToPoint(columnContext, xCoord, yCoord)//start here
        
        yCoord = yCoord + lengthOfLine//move down
        
        CGContextAddLineToPoint(columnContext, xCoord, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(columnContext)

    }
    
}




