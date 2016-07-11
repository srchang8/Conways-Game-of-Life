//
//  ViewController.swift
//  Assignment3
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
   
  
    
    @IBAction func RunButton(sender: AnyObject) {
        
        
        let NumColumns: Int = 10
        let NumRows: Int = 10
        var numOfLivingCellsInBefore: Int = 0
        var numOfLivingCellsInAfter: Int = 0
        var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        var afterStep = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        
        print("run button pressed")
        
        
        //create 2d array of bools with random state values
        //update the grid with it
        //use step and update the 2d array of bools
        //update the grid
        
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

