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
        
        var after = step(gridView.before)
        

        
        if  let touch = touches.first {
            
            
            //let position :CGPoint = touch.locationInView(view)
            
            let position :CGPoint = touch.locationInView(view)
            
            /*
            var xPosition = position.x
            var yPosition = position.y
            */
            
            var xCGFloat = position.x
            var yCGFloat = position.y
            
            print("CGFloat coordinates before \(xCGFloat) \(yCGFloat)")
            
            xCGFloat = (floor((xCGFloat - gridView.xStart)/10))
            yCGFloat = (floor((yCGFloat - gridView.yStart)/10))
            
            //xFloat = (floor((xFloat - 50 )/10))
            
            
            var xInt = Int(xCGFloat)
            var yInt = Int(yCGFloat)
            
            print("CGFloat coordinates after \(xCGFloat) \(yCGFloat)")
            
            //if gridView.before[yInt][xInt] == false{
                
                gridView.before[yInt][xInt] = true
                //gridView.grid[yInt][xInt] = toggle(gridView.grid[yInt][xInt])
            
            print("after toggle it returns \(gridView.grid[yInt][xInt])")
            
                print("draw circle on \(yInt) \(xInt)")
                print("gridView before values true or false \(gridView.before[yInt][xInt])")
                gridView.setNeedsDisplay()
            //}
            
            //gridView.fillCell(xCGFloat, yCoord: yCGFloat)
            
            
        }
        
        
        
        
    }//ends touchesBegan
    
    
    
    
    
    //iterate button
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
                    
                    print("fillCell x: \(xFromIntToCGF) y: \(yFromIntToCGF) ")
                    
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
        
        
        
        /*
        
        //put everything from after to before, as after needs to become the new before
        //could have done this in the above for loops,
        //but I feel this will make it easier for me to read my code in the future
        
        for y in 0..<gridView.cols{
            for x in 0..<gridView.rows{
                
                //cast into to GCF
                //let xFromIntToCGF = CGFloat(x)
                //let yFromIntToCGF = CGFloat(y)
                
                
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
        
        */
        
    }//closes runButton
    
    
    //Start button
    @IBAction func populateButton(sender: UIButton) {
        
     
        //clear existing if any grid
        for y in 0..<gridView.cols{//iterate 0-9
            for x in 0..<gridView.rows{//iterate 0-9
                
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                gridView.grid[y][x] = .Empty
                gridView.before[y][x] = false
                
            }
        }
        
        
        
        //initialize before array with random bools and update enum grid
        for y in 0..<gridView.cols{//iterate 0-9
            for x in 0..<gridView.rows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    
                    gridView.before[y][x] = true
                    gridView.numOfLivingCellsInBefore+=1
                    
                    //Fill alive cells
                    let xFromIntToCGF = CGFloat(x)
                    let yFromIntToCGF = CGFloat(y)
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                    
                    //update enum grid
                    gridView.grid[y][x] = .Living
                    
                    
                }
                else{
                    //update enum grid
                    gridView.grid[y][x] = .Empty
                    
                    //Fill in the empty cells
                    let xFromIntToCGF = CGFloat(x)
                    let yFromIntToCGF = CGFloat(y)
                    //gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
            }
            
        }//ends initialize before array
        
        gridView.setNeedsDisplay()
        
        
        
    }//ends populateButton
        
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}//ends view controller
    






