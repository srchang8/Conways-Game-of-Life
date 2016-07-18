//
//  SimulationViewController.swift
//  Assignment3
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.



import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    //creat outlet for gridview
    //allows you to use stuff in GridView
    @IBOutlet weak var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StandardEngine.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let rows = PersistenceService.sharedInstance.numberOfRows
        let cols = PersistenceService.sharedInstance.numberOfCollumns
        StandardEngine.sharedInstance.grid = Grid(rows: rows, cols: cols)
    }
    
    // MARK: - EngineDelegate
    
    func engineDidUpdate(withGrid: GridProtocol) {
        if let grid = withGrid as? Grid {
            self.gridView.grid = grid
        }
    }
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        StandardEngine.sharedInstance.grid = self.gridView.before
        StandardEngine.sharedInstance.step()
        
        if  let touch = touches.first {
            
            //let position :CGPoint = touch.locationInView(view)
            
            let position :CGPoint = touch.locationInView(view)
            
            var xCGFloat = position.x
            var yCGFloat = position.y
            
            print("CGFloat coordinates before \(xCGFloat) \(yCGFloat)")
            
            xCGFloat = (floor((xCGFloat - gridView.xStart)/10))
            yCGFloat = (floor((yCGFloat - gridView.yStart)/10))
            
            //xFloat = (floor((xFloat - 50 )/10))
            
            
            let xInt = Int(xCGFloat)
            let yInt = Int(yCGFloat)
            
            print("CGFloat coordinates after \(xCGFloat) \(yCGFloat)")
            
            //if gridView.before[yInt][xInt] == false{
            
            gridView.before[yInt, xInt] = .Living
            //gridView.grid[yInt][xInt] = toggle(gridView.grid[yInt][xInt])
            
            print("after toggle it returns \(gridView.grid[yInt, xInt])")
            
            print("draw circle on \(yInt) \(xInt)")
            print("gridView before values true or false \(gridView.before[yInt, xInt])")
            gridView.setNeedsDisplay()
            //}
            
            //gridView.fillCell(xCGFloat, yCoord: yCGFloat)
            
            
        }
        
        
        
        
    }//ends touchesBegan
    
    
    
    
    
    //iterate button
    @IBAction func runButton(sender: UIButton) {
        
        //create after array variable
        StandardEngine.sharedInstance.grid = self.gridView.before
        let after = StandardEngine.sharedInstance.step()
        
        
        
        //put array named: after into the grid 20x20
        for y in 0..<gridView.grid.cols{
            for x in 0..<gridView.grid.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                switch after[y, y] {
                case .Living, .Born:
                    
                    //draw circle in the grid
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                    
                    //update enum grid
                    gridView.grid[y, x] = .Living
                    
                //update before so it become the new after
                case .Died, .Empty:
                    
                    //update enum grid
                    gridView.grid[y, x] = .Died
                    
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
        
        for y in 0..<gridView.grid.cols{
            for x in 0..<gridView.grid.rows{
                
                //cast into to GCF
                //let xFromIntToCGF = CGFloat(x)
                //let yFromIntToCGF = CGFloat(y)
                
                
                switch after[y, y] {
                case .Living, .Born:
                    
                    //update before so it become the new after
                    gridView.before[y, x] = .Living
                    
                //update before so it become the new after
                case .Died, .Empty:
                    
                    //update before so it become the new after
                    gridView.before[y, x] = .Died
                }
                
            }
        }
        
        
        
    }//closes runButton
    
    
    
    @IBAction func populateButton(sender: UIButton) {
        
        
        //clear existing if any grid
        for y in 0..<gridView.grid.cols{//iterate 0-9
            for x in 0..<gridView.grid.rows{//iterate 0-9
                
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                gridView.grid[y, x] = .Empty
                gridView.before[y, x] = .Empty
                
            }
        }
        
        
        
        //initialize before array with random bools and update enum grid
        for y in 0..<gridView.grid.cols{//iterate 0-9
            for x in 0..<gridView.grid.rows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    
                    gridView.before[y, x] = .Living
                    gridView.numOfLivingCellsInBefore+=1
                    
                    //Fill alive cells
                    let xFromIntToCGF = CGFloat(x)
                    let yFromIntToCGF = CGFloat(y)
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                    
                    //update enum grid
                    gridView.grid[y, x] = .Living
                    
                    
                } else {
                    //update enum grid
                    gridView.grid[y, x] = .Empty
                    
                    //Fill in the empty cells
//                    let xFromIntToCGF = CGFloat(x)
//                    let yFromIntToCGF = CGFloat(y)
                    //gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
            }
            
        }//ends initialize before array
        
        
        /*
         // Draw put array named before into the grid
         for y in 0..<gridView.cols{
         for x in 0..<gridView.rows{
         
         //cast into to GCF
         let xFromIntToCGF = CGFloat(x)
         let yFromIntToCGF = CGFloat(y)
         
         if gridView.before[y][x] == true {
         
         //print("xFromIntToCGF\(xFromIntToCGF) yFromIntToCGF\(yFromIntToCGF)")
         gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
         }
         
         }
         }//ends put array named before into grid
         */
        gridView.setNeedsDisplay()
        
        
        
    }//ends populateButton
    
    
}//ends view controller







