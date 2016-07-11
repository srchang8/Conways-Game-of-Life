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
    

    override func drawRect(rect: CGRect){
        
        let context = UIGraphicsGetCurrentContext()//the object is the brush
        CGContextSetLineWidth(context, gridWidth)
        CGContextSetStrokeColorWithColor(context, gridColor)
        
       
        var xCoord: CGFloat = 550
        var yCoord: CGFloat = 30
        
        
        for var y = 0; y < rows; y+=1 {
            
            
            
            //Straight line
            CGContextMoveToPoint(context, 30, 30)//start here
            CGContextAddLineToPoint(context, xCoord, yCoord)//end here
            
            //length of each horizontal line is 520
            xCoord = xCoord + 520
            
            //Distance from start point to next start point
            yCoord = yCoord + 10
            
            
        
            //Actually draw the path
            CGContextStrokePath(context)
            
        }
    }
   

    //function that takes in coordinates and draws a line from that
    func drawRowLine(xCoord: CGFloat, yCoord: CGFloat){
        
        let brushContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(brushContext, gridWidth)
        CGContextSetStrokeColorWithColor(brushContext, gridColor)
        
        let lengthOfLine: Int = 500
        let heightBetweenLines: Int = 30
        
        CGContextMoveToPoint(brushContext, xCoord, yCoord)//start here
        
        
        
        CGContextAddLineToPoint(brushContext, xCoord, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(brushContext)
        
        
        
    }
    
}
//function that takes in coordinates and returns a coordinate for CGContextAddLineToPoint

//



