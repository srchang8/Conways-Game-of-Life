//  StatisticsViewController.swift


import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var statisticLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.didUpdateGridWithNotification(_:)), name: EngineDidUpdateGridNotificationName, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.didResetGridWithNotification(_:)), name: ResetPressedNotificationName, object: nil)
        self.grid = StandardEngine.sharedInstance.grid
    }
    
    var grid : GridProtocol? {
        didSet {
            if let grid = self.grid {
                
                var livingCount = 0
                var emptyCount = 0
                var diedCount = 0
                var bornCount = 0
                
                for j in 0..<grid.cols {
                    for i in 0..<grid.rows {
                        switch grid[i, j] {
                        case .Born:
                            bornCount += 1
                        case .Living:
                            livingCount += 1
                        case .Died:
                            diedCount += 1
                        case .Empty:
                            emptyCount += 1
                        }
                    }
                }
                
                
                self.statisticLabel.text = " emptyCount: \(emptyCount)\n bornCount: \(bornCount)\n livingCount: \(livingCount)\n diedCount: \(diedCount)"
            }
        }
    }
    
    func didUpdateGridWithNotification(notification: NSNotification) {
        // TODO: finish
        if let userInfo = notification.userInfo, grid = userInfo["grid"] as? GridProtocol {
            self.grid = grid
        }
    }
    
    func didResetGridWithNotification(notification: NSNotification) {
        // Resetting the grid
        if let userInfo = notification.userInfo, grid = userInfo["grid"] as? GridProtocol {
            self.grid = grid
        }
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
