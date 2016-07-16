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
    
    //MARK: Create before array Problem 6
    let NumColumns: Int = 20
    let NumRows: Int = 20
    var numOfLivingCellsInBefore: Int = 0
    var numOfLivingCellsInAfter: Int = 0
    
    var before = Array(count:20, repeatedValue: Array(count:20, repeatedValue:false))
    
    
    override func drawRect(rect: CGRect)
    {
        
        
        //initialize before array with random bools
        for y in 0..<NumColumns{//iterate 0-9
            for x in 0..<NumRows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    before[y][x] = true
                    numOfLivingCellsInBefore+=1
                    
                    //update enum grid
                    grid[y][x] = .Living
                    
                    
                }
                else{
                    //update enum grid
                    grid[y][x] = .Empty
                    
                    //Fill in the empty cells
                    let xFromIntToCGF = CGFloat(x)
                    let yFromIntToCGF = CGFloat(y)
                    emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
            }
            
        }
        
        
        
        
        //MARK: draw cells
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
        
        
        /*
        //MARK: Draw Circles
        
        
         //this is hw3 part4
         for y in 0..<cols{
            for x in 0..<rows{
         
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
         
                fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
         
         
            }
         }
        */
       
      
        
        
        
        //put array named before into the grid
        for y in 0..<cols{
            for x in 0..<rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                if before[y][x] == true {
                    
                    fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
                
            }
        }
        
       
        
        /*
         
         //put array named: after into the grid
         for y in 0..<cols{
         for x in 0..<rows{
         
         //cast into to GCF
         let xFromIntToCGF = CGFloat(x)
         let yFromIntToCGF = CGFloat(y)
         
         if step(before)[y][x] == true {
         
         fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
         }
         
         }
         }
         
         */
        
        
        
        
    }//override rect function closing bracket
    
    
    
    /*
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        
        //put array named: after into the grid
        for y in 0..<cols{
            for x in 0..<rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                if step(before)[y][x] == true {
                    
                    fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
                
            }
        }
        
     /*
     
     //create button
     let button = UIButton(frame: CGRect(x: 250, y:250, width: 44, height: 44))
     button.backgroundColor = UIColor.redColor()
     button.addTarget(self, action: #selector(GridView.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
     addSubview(button)
     */

     
     
     
        */
        
    
    
    
    
    //MARK: functions
    
    //takes coordinates and fills the the respective cell
    func fillCell(var xCoord: CGFloat, var yCoord: CGFloat){
        
        var xCoordIn = xCoord
        var yCoordIn = yCoord
        
 
 
        //cast CGFloat to int
        var xCoordInt = Int(xCoordIn)
        var yCoordInt = Int(yCoordIn)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        xCoord = xCoord*10 + xStart
        yCoord = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoord, yCoord, 10, 10))
        
        
        //sets the colors by checking grid
        if toggle(grid[xCoordInt][yCoordInt]) == .Living {
            //living color is green
            livingColor.setFill()
            
        }
        
        if toggle(grid[xCoordInt][yCoordInt]) == .Empty {
            //empty color is dark gray
            emptyColor.setFill()
            
        }
        
        
        
        
        //fill the circle
        circlePath.fill()

        
    }
    
    
    
    func emptyCell(var xCoord: CGFloat, var yCoord: CGFloat){
        
        var xCoordIn = xCoord
        var yCoordIn = yCoord
        
        
        
        //cast CGFloat to int
        var xCoordInt = Int(xCoordIn)
        var yCoordInt = Int(yCoordIn)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        xCoord = xCoord*10 + xStart
        yCoord = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoord, yCoord, 10, 10))
        
        
       //set color to empty cell dark gray
        emptyColor.setFill()
            
        
        
        
        
        
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
    
    
    
    
}//Last bracket




