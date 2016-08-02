//  SimulationViewController.swift



import UIKit

// The user should be allowed to edit the cells and retain the representation in the tableview going forward.
// Therefore we need to retain the index so we can later replace a configuration in an array with a new value
protocol SimulationViewControllerDelegate : class {
    func didSaveConfiguration(configuration: Configuration, atIndex index: Int)
}

class SimulationViewController: UIViewController, EngineDelegate {
    
    //creat outlet for gridview
    //allows you to use stuff in GridView
    @IBOutlet weak var gridView: GridView!
    
    var configuration : Configuration!
    var configurationIndex = 0
    
    @IBOutlet weak var gridHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gridWidthConstraint: NSLayoutConstraint!
    
    weak var delegate : SimulationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set itself as the delegate of the StandardEngine singleton
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
        
        // Custom configuration -> points and title
        if configuration != nil {
            gridView.grid = Grid(rows: rows, cols: cols)
            gridView.points = configuration.contents
            title = configuration.title
        }
        
        // Resize the scrollable gridview
        gridHeightConstraint.constant = CGFloat(cols * 10)
        gridWidthConstraint.constant = CGFloat(rows * 10)
    }
    
    // MARK: - EngineDelegate
    
    func engineDidUpdate(withGrid: GridProtocol) {
        if let grid = withGrid as? Grid {
            self.gridView.grid = grid
        }
    }
    
    
    
    //iterate button = runButton
    @IBAction func runButton(sender: UIButton) {
        StandardEngine.sharedInstance.step()
        
    }
    
    
    //start button = populateButton
    @IBAction func populateButton(sender: UIButton) {
        
        

        let grid = StandardEngine.sharedInstance.grid
        
        /*
        //clear existing if any grid
        for y in 0..<grid.cols{//iterate 0-9
            for x in 0..<grid.rows{//iterate 0-9
                grid[y, x] = .Empty
            }
        }
                */
        
        
        
        
        
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
        StandardEngine.sharedInstance.scheduleTimer()
        
    }//ends populateButton
    
    
    
    // -------------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------------
    
    @IBAction func savePressed(sender: AnyObject) {
        // Upon save we retrieve the currently living set of points
        configuration.contents = gridView.points
        // And pass it to the delegate if such exists
        self.delegate?.didSaveConfiguration(configuration, atIndex: configurationIndex)
        // Unwind segue
        self.performSegueWithIdentifier("unwindToInstrumentationVC", sender: nil)
    }
    
    
    
    @IBAction func createNewPressed(sender: AnyObject) {
        // display an alert
        let alert = UIAlertController(title: "Save Configuration", message: "Please type the name of the newly created configuration", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler(addTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: createNewConfigurationConfirmed))
        presentViewController(alert, animated: true, completion: nil)
    }
    func createNewConfigurationConfirmed(alert: UIAlertAction!){
        
        guard let name = self.configurationNameTextField?.text else {
            return
        }
        
        let config = Configuration()
        config.title = name
        config.contents = gridView.points // the getter of points should work here
        
        // Sending the configuration via NSNotification so unrelated viewcontrollers can react accordingly
        NSNotificationCenter.defaultCenter().postNotificationName(CreateNewConfigurationNotificationName, object: nil, userInfo: ["configuration" : config])
    }
    var configurationNameTextField : UITextField?
    func addTextField(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "The name of configuration"
        self.configurationNameTextField = textField
    }
    
    
    
    @IBAction func resetPressed(sender: AnyObject) {
        
        // Reset to the predefined dimensions, empty grid
        let rows = PersistenceService.sharedInstance.numberOfRows
        let cols = PersistenceService.sharedInstance.numberOfCollumns
        gridView.grid = Grid(rows: rows, cols: cols)
        
        // Grid was reset
        NSNotificationCenter.defaultCenter().postNotificationName(ResetPressedNotificationName, object: nil, userInfo: ["grid" : gridView.grid])
    }
    
    
}//ends view controller







