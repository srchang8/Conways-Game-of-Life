//
//  StatisticsViewController.swift
//  Assignment3
//
//  Created by Stephen Chang on 18/07/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.didUpdateGridWithNotification(_:)), name: EngineDidUpdateGridNotificationName, object: nil)
    }
    
    func didUpdateGridWithNotification(notification: NSNotification) {
        // TODO: finish
        if let userInfo = notification.userInfo, grid = userInfo["grid"] as? GridProtocol {
            print(grid)
        }
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
