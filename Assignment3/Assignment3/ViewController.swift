//
//  ViewController.swift
//  Assignment3
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.



import UIKit

class ViewController: UIViewController {
    
    //creat outlet for gridview
    //allows you to use stuff in GridView
    @IBOutlet weak var gridView: GridView!
    
    @IBOutlet weak var touchGrid: GridView!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        let after = step(gridView.before)
        
      
        
        if  let touch = touches.first {
            
            
            //let position :CGPoint = touch.locationInView(view)
            
            let position :CGPoint = touch.locationInView(view)
            
            var xPosition = position.x
            var yPosition = position.y
            
            var xCGFloat = position.x
            var yCGFloat = position.y
            
            print("CGFloat coordinates before \(xCGFloat) \(yCGFloat)")
            xCGFloat = (floor((xCGFloat - gridView.xStart)/10))
            yCGFloat = (floor((yCGFloat - gridView.yStart)/10))
            //xFloat = (floor((xFloat - 50 )/10))
            
            
            /*
            //cast CGFloat to string and get first 2
            var xString = String(xPosition)
            var yString = String(yPosition)
            
            let rangeOfxString = Range(start: xString.startIndex, end: xString.startIndex.advancedBy(2))
            let xfirstTwoDigits = xString[rangeOfxString]
       
          
            let rangeOfyString = Range(start: yString.startIndex, end: yString.startIndex.advancedBy(2))
            let yfirstTwoDigits = yString[rangeOfyString]
            
            //cast back to int
            var xInt = Int(xfirstTwoDigits)
            var yInt = Int(yfirstTwoDigits)
            
            
            xPosition = (xPosition - 50)/10
            yPosition = (yPosition - 50)/10
            */
            
            print("CGFloat coordinates after \(xCGFloat) \(yCGFloat)")
            gridView.fillCell(xCGFloat, yCoord: yCGFloat)
            
            gridView.setNeedsDisplay()
            
          

            /*
            if xInt < 20 && yInt < 20 {
                
                if gridView.before[yInt][xInt] == false {
                
                    //cast from int to CGF for fill and empty cell function
                
                
                    let xCGFloat = CGFloat(xInt)
                    let yCGFloat = CGFloat(yInt)
 
                
                    gridView.fillCell(xCGFloat, yCoord: yCGFloat)
                    print("@@@@@@@ Fill")
                    
                    //update grid
                    gridView.setNeedsDisplay()
                
                }
                
                
                if gridView.before[yInt][xInt] == true {
                    
                    let xCGFloat = CGFloat(xInt)
                    let yCGFloat = CGFloat(yInt)
                    
                    
                    gridView.emptyCell(xCGFloat, yCoord: yCGFloat)
                    print("@@@@@@@ empty")
            
                    
                    //update grid
                    gridView.setNeedsDisplay()
                    
                }
            
            
            }
            */
            
            
            
            /*
            
            //create circle context with at position (xCoord, yCoord) with size 10x10
            let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCGFloat, yCGFloat, 10, 10))
            
        
            
            
            
            gridView.livingColor.setFill()
            
            //fill the circle
            circlePath.fill()
            
            */
            
            
            //if before[y][x] is empty
                //fill it
                //mark grid as living
                //update before aray position to true
            // if it is alive
                // empty it
                //mark grid as empty
                //update before array position to false
            
        }
        
 
        
        
    }
 
    
    
    
    
     
    @IBAction func runButton(sender: UIButton) {
        
        //create after array variable
        let after = step(gridView.before)
         

        
        //put array named: after into the grid 20x20
        for y in 0..<gridView.cols{
            for x in 0..<gridView.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                if after[y][x] == true {
                    
                    //draw circle in the grid
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                    
                    //update enum grid
                    gridView.grid[y][x] = .Living
                    
                    //update before so it become the new after
                    
                    
                }
                else if after[y][x] == false {
                    
                    
                    //update enum grid
                    gridView.grid[y][x] = .Died
                    
                    //empty the cell
                    gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                   
                    
                }
                
            }
        }
       
      //update view
      gridView.setNeedsDisplay()
      
        
        
        //put everything from after to before, as after needs to become the new before 
        //could have done this in the above for loops, 
        //but I feel this will make it easier for me to read my code in the future
        
        for y in 0..<gridView.cols{
            for x in 0..<gridView.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                if after[y][x] == true {
                    
                    //update before so it become the new after
                    gridView.before[y][x] = true
                    
                    
                }
                else if after[y][x] == false {
                    
                    
                    //update before so it become the new after
                    gridView.before[y][x] = false
                    
                    
                }
                
            }
        }
        
    

    }//closes runButton
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}





