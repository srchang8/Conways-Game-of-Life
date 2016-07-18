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
        let grid = StandardEngine.sharedInstance.grid
        if grid.cols != cols && grid.rows != rows {
            StandardEngine.sharedInstance.grid = Grid(rows: rows, cols: cols)
        }
    }
    
    // MARK: - EngineDelegate
    
    func engineDidUpdate(withGrid: GridProtocol) {
        if let grid = withGrid as? Grid {
            self.gridView.grid = grid
        }
    }
    
    
    //couldn't get this working in time.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        StandardEngine.sharedInstance.step()
        
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
            
            //gridView.grid[yInt, xInt] = .Living
            //gridView.grid[yInt][xInt] = toggle(gridView.grid[yInt][xInt])
            //gridView.setNeedsDisplay()
            //}
            
            //gridView.fillCell(xCGFloat, yCoord: yCGFloat)
            
            
        }
        
        
        
        
    }//ends touchesBegan
    
    
    
    
    @IBAction func runButton(sender: UIButton) {
        StandardEngine.sharedInstance.step()
    }
    
    @IBAction func populateButton(sender: UIButton) {
        
        let grid = StandardEngine.sharedInstance.grid
        
        //clear existing if any grid
        for y in 0..<grid.cols{//iterate 0-9
            for x in 0..<grid.rows{//iterate 0-9
                grid[y, x] = .Empty
            }
        }
        
        
        
        //initialize before array with random bools and update enum grid
        for y in 0..<grid.cols{//iterate 0-9
            for x in 0..<grid.rows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    gridView.numOfLivingCellsInBefore+=1
                    
                    //update enum grid
                    grid[y, x] = .Living
                    
                    
                } else {
                    //update enum grid
                    grid[y, x] = .Empty
                }
            }
            
        }//ends initialize before array
        
        
        StandardEngine.sharedInstance.grid = grid
        
        
    }//ends populateButton
    
    
}//ends view controller







