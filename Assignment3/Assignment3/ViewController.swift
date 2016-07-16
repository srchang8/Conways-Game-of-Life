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
    
    
    
    
     
    @IBAction func runButton(sender: UIButton) {
        //var grid = gridView.grid
        //gridView.grid = //...
         
       
        
        //gridView.fillCell(10, yCoord: 10)
        
        //var gridArray = gridView.grid
        //var gridArrayy = step(gridView.before)
        
        
        //put array named: after into the grid
        for y in 0..<gridView.cols{
            for x in 0..<gridView.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                if step(gridView.before)[y][x] == true {
                    
                    //draw circle in the grid
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                    
                    //update enum grid
                    gridView.grid[y][x] = .Living
                    
                }
                else if step(gridView.before)[y][x] == false {
                    
                    //issue is when it gets here false could either mean dead or empty
                    //how does step tell us if it was empty or dead
                    //how do you know if it should be Died or empty
                    
                    //update enum grid
                    gridView.grid[y][x] = .Died
                    
                    gridView.emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                   
                    
                }
                
            }
        }
        
      gridView.setNeedsDisplay()
        
        
        
      
 
 
 
        /*
         //put array named: after into the grid
         for y in 0..<gridView.cols{
            for x in 0..<gridView.rows{
         
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
         
                if step(before)[y][x] == true {
         
                    gridView.fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
         
            }
         }
        
        */
         
 
        

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






//gridView set needs display gridView.setNeedsDisplay
// grid should go into step in function

//get grid from gribire
//run step from engine
//use button to update array

//gridView.grid = newGrid

//gridViewsetNeedsDisplay() will draw it again

