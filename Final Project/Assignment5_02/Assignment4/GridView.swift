//  GridView.swift


import UIKit

@IBDesignable//Let interface builder know that it should render the view directly in the canvas. Allows seeing how your custom views will appear without building and running your app after each change
class GridView: UIView {
    
    //everytime rows or cols changes grid array must reinitialize to all empty
    @IBInspectable var livingColor: UIColor = UIColor()
    @IBInspectable var emptyColor: UIColor = UIColor()
    @IBInspectable var bornColor: UIColor = UIColor()
    @IBInspectable var diedColor: UIColor = UIColor()
    @IBInspectable var gridColor: CGColor!
    
    @IBInspectable var gridWidth: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add the tap gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GridView.didTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func didTap(gestureRecognizer: UITapGestureRecognizer) {
        // Get the position within the view
        let position = gestureRecognizer.locationOfTouch(0, inView: self)
        let x = Int(floor((position.x - xStart)/gridWidth))
        let y = Int(floor((position.y - yStart)/gridWidth))
        // Toggle the living state
        if (grid[x, y].isLiving()) {
            grid[x, y] = .Empty
        } else {
            grid[x, y] = .Living
        }
        // Refresh
        setNeedsDisplay()
    }
    
    var points:[(Int,Int)] {
        set {
            // Fist we create a brand new Grid with all empty points
            grid = Grid(rows: grid.rows, cols: grid.cols)
            // Now we put the living points to live
            for point in newValue {
                if point.0 < grid.rows && point.1 < grid.cols &&
                point.0 > 0 && point.1 > 0 {
                    grid[point.0, point.1] = .Living
                }
            }
        }
        get {
            // Gathering all the living points from the grid
            var points = [(Int, Int)]()
            for y in 0..<grid.cols{
                for x in 0..<grid.rows{
                    let point = grid[x,y]
                    if point.isLiving() {
                        points.append((x,y))
                    }
                }
            }
            return points
        }
    }
    
    
    //a 2D array of CellState values called grid which reinitialize to all .Empty values every time rows or cols changes using didSet keyword on the rows and cols values
    var grid = Grid(rows: 10, cols: 10) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    //start positions for on GridView if ever needed
    let xStart: CGFloat = 0//start position for x coordinate
    let yStart: CGFloat = 0// start position for y coordinate
    
    //MARK: Create before array
    var numOfLivingCellsInBefore: Int = 0
    var numOfLivingCellsInAfter: Int = 0
    
    override func drawRect(rect: CGRect)
    {
        //Draw rows
        for i in 0...self.grid.cols {
            drawRowLine(xStart, yCoord: yStart + CGFloat(i) * gridWidth)
        }
        
        //draw columns
        for i in 0...self.grid.rows {
            drawColumnLine(xStart + CGFloat(i) * gridWidth, yCoord: yStart)
        }
       
        
        
        //draw before array into the grid
        for x in 0..<self.grid.cols{
            for y in 0..<self.grid.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                switch self.grid[x, y] {
                case .Living, .Born:
                    fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                case .Empty, .Died:
                    emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
                
            }
        }
    }//override rect function closing bracket
    
    
    
    
    
    
    //MARK: functions
    
    //takes in CGFloat coordinates and fills the the respective cell
    func fillCell(xCoord: CGFloat, yCoord: CGFloat){
        
        //cast CGFloat to int
        let xCoordInt = Int(xCoord)
        let yCoordInt = Int(yCoord)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        let xCoordIn = xCoord*10 + xStart
        let yCoordIn = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoordIn, yCoordIn, 10, 10))
        
        
        
        //print("xCoordInt and yCoordInt inside Fill \(xCoordInt) \(yCoordInt)")
        
        switch grid[xCoordInt, yCoordInt] {
        case .Living, .Born:
            livingColor.setFill()
        case .Empty, .Died:
            emptyColor.setFill()
        }
        
        //fill the circle
        circlePath.fill()
        //gridView.setNeedsDisplay()
        
        
    }
    
    
    
    func emptyCell(xCoord: CGFloat, yCoord: CGFloat){
        
        //cast CGFloat to int
//        var xCoordInt = Int(xCoordIn)
//        var yCoordInt = Int(yCoordIn)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        let xCoordIn = xCoord*10 + xStart
        let yCoordIn = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoordIn, yCoordIn, 10, 10))
        
        
        
        //set color to empty cell dark gray
        emptyColor.setFill()
        
        
        
        //fill the circle
        circlePath.fill()
        
        
        
    }
    
    
    
    //function that takes in coordinates and draws a horizontal line
    func drawRowLine(xCoord: CGFloat, yCoord: CGFloat)
    {
        
        let rowContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(rowContext, 1)
        CGContextSetStrokeColorWithColor(rowContext, gridColor)
    
        //cast so we can multiple rows by gridWidth to get length of line
        let gridRowsCGFloat = CGFloat(self.grid.rows)
        
        //length of each line
        let lengthOfLine: CGFloat = CGFloat(gridRowsCGFloat * gridWidth)
        
        
        CGContextMoveToPoint(rowContext, xCoord, yCoord)//start here
        
        let xCoordIn = xCoord + lengthOfLine//move right
        
        CGContextAddLineToPoint(rowContext, xCoordIn, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(rowContext)
        
        
    }
    
    
    
    //takes in coordinates and draws vertical line
    func drawColumnLine(xCoord: CGFloat, yCoord: CGFloat)
    {
        let columnContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(columnContext, 1)
        CGContextSetStrokeColorWithColor(columnContext, gridColor)
        
        //cast so we can multiple cols by gridWidth to get length of line
        let gridColsCGFloat = CGFloat(self.grid.cols)
        
        //length of each line
        let lengthOfLine: CGFloat = CGFloat(gridColsCGFloat * gridWidth)
        
        CGContextMoveToPoint(columnContext, xCoord, yCoord)//start here
        
        let yCoordIn = yCoord + lengthOfLine//move down
        
        CGContextAddLineToPoint(columnContext, xCoord, yCoordIn)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(columnContext)
        
    }
    
    
    
    
}//Last bracket




