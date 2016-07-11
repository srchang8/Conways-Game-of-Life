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
        
        
        
        
        
            var startAngle: Float = Float(2 * M_PI)
            var endAngle: Float = 0.0
            
            // Drawing code
            // Set the radius
            let strokeWidth = 1.0
        
            //let radius = CGFloat((CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 2)
            let radius = CGFloat(5)
            
            // Get the context
            var circleContext = UIGraphicsGetCurrentContext()
            
            // Find the middle of the circle
            //let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
            
            // Set the stroke color
            CGContextSetStrokeColorWithColor(circleContext, gridColor)//changed to grid color
            
            // Set the line width
            CGContextSetLineWidth(circleContext, CGFloat(strokeWidth))
            
            // Set the fill color (if you are filling the circle)
            CGContextSetFillColorWithColor(circleContext, UIColor.clearColor().CGColor)
            
            // Rotate the angles so that the inputted angles are intuitive like the clock face: the top is 0 (or 2π), 
            //the right is π/2, the bottom is π and the left is 3π/2.
            // In essence, this appears like a unit circle rotated π/2 anti clockwise.
            startAngle = startAngle - Float(M_PI_2)
            endAngle = endAngle - Float(M_PI_2)
            
            // Draw the arc around the circle
            //CGContextAddArc(circleContext, center.x, center.y, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 0)
        
            CGContextAddArc(circleContext, 55, 55, CGFloat(radius), CGFloat(startAngle), CGFloat(endAngle), 0)
            
            // Draw the arc
            CGContextDrawPath(circleContext, CGPathDrawingMode.FillStroke)
            
        
        
        
        
        
    }//override rect function closing bracket
        
        
    
    
    
    
    
    
    
    
    
    
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




