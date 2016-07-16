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
        
        //create after array variable
        let after = step(gridView.before)
         

        
        //put array named: after into the grid
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





