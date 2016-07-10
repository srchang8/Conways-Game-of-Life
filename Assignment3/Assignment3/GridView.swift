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
    


    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, gridWidth)
        CGContextSetStrokeColorWithColor(context, gridColor)
        /*UIColor.blackColor().CGColor*/
        
        
        CGContextMoveToPoint(context, 30, 90)
        CGContextAddLineToPoint(context, 200, 90)
        
        //Actually draw the path
        CGContextStrokePath(context)
        
    }
    
}





