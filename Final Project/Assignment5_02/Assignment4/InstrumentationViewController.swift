//  InstrumentationViewController.swift



import UIKit

class InstrumentationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SimulationViewControllerDelegate {

    @IBOutlet weak var numberOfRowsTextField: UITextField!
    @IBOutlet weak var numberOfColumnsTextField: UITextField!
    @IBOutlet weak var numberOfRowsStepper: UIStepper!
    @IBOutlet weak var numberOfColumnsStepper: UIStepper!
    @IBOutlet weak var timedRefreshSwitch: UISwitch!
    @IBOutlet weak var refreshRateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sourceURLTextField: UITextField!
    
    var items = [Configuration]()
    
    func refreshUI() {
        
        
        let stepperRows = round(Double(self.numberOfRows) / 10.0) * 10.0
        let stepperCols = round(Double(self.numberOfCollumns) / 10.0) * 10.0
        self.numberOfRowsStepper.value = stepperRows
        self.numberOfColumnsStepper.value = stepperCols
        
        
        self.numberOfRowsTextField.text = String(self.numberOfRows)
        self.numberOfColumnsTextField.text = String(self.numberOfCollumns)
        
        let displayRate = round(self.refreshRate * 10.0) / 10.0
        self.refreshRateLabel.text = "\(displayRate) Hz"
        
        self.timedRefreshSwitch.on = self.timedRefresh
    }
    
    var numberOfRows : Int {
        get {
            return PersistenceService.sharedInstance.numberOfRows
        }
        set {
            PersistenceService.sharedInstance.numberOfRows = newValue
            self.refreshUI()
        }
    }
    var numberOfCollumns : Int {
        get {
            return PersistenceService.sharedInstance.numberOfCollumns
        }
        set {
            PersistenceService.sharedInstance.numberOfCollumns = newValue
            self.refreshUI()
        }
    }
    var refreshRate : Double {
        get {
            return PersistenceService.sharedInstance.refreshRate
        }
        set {
            PersistenceService.sharedInstance.refreshRate = newValue
            self.refreshUI()
        }
    }
    var timedRefresh : Bool {
        get {
            return PersistenceService.sharedInstance.timedRefresh
        }
        set {
            PersistenceService.sharedInstance.timedRefresh = newValue
            self.refreshUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InstrumentationViewController.didCreateNewConfiguration(_:)), name: CreateNewConfigurationNotificationName, object: nil)
    }
    
    func didCreateNewConfiguration(notification: NSNotification) {
        if let config = notification.userInfo?["configuration"] as? Configuration {
            items.append(config)
            tableView.reloadData()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refreshUI()
    }
    
    @IBAction func refreshRateSliderValueChanged(sender: UISlider) {
        self.refreshRate = Double(sender.value)
    }
    @IBAction func numberOfRowsStepperValueChanged(sender: UIStepper) {
        self.numberOfRows = Int(sender.value)
    }
    @IBAction func numberOfColumnsStepperValueChanged(sender: UIStepper) {
        self.numberOfCollumns = Int(sender.value)
    }
    @IBAction func timedRefreshSwitchValueChanged(sender: UISwitch) {
        self.timedRefresh = sender.on
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text {
            switch textField {
            case self.numberOfRowsTextField:
                self.numberOfRows = Int(text) ?? 0
                
            case self.numberOfColumnsTextField:
                self.numberOfCollumns = Int(text) ?? 0
            default:
                break
            }
        }
    }
    
    @IBAction func didTapOnBackground(sender: AnyObject) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func refreshData() {
        // This is the network request method
        // It is performed on a background thread
        unowned let weakSelf = self
        NetworkService.sharedInstance.getConfigurations(sourceURLTextField.text!, success: { (configurations) in
            // The UI should be handled on the main thread, therefore we need to bring it there
            dispatch_async(dispatch_get_main_queue(), { 
                weakSelf.items = configurations
                weakSelf.tableView.reloadData()
            })
        }) { (error) in
            dispatch_async(dispatch_get_main_queue(), {
                UIAlertController.presentOKAlertWithError(error)
            })
        }
    }
    
    @IBAction func reloadPressed(sender: AnyObject) {
        refreshData()
    }
    
    
    // -------------------------------------------------------------------------------
    // MARK: - UITableViewDataSource
    // -------------------------------------------------------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        // Setting the title of the selecting
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    
    
    // -------------------------------------------------------------------------------
    // MARK: - Navigation
    // -------------------------------------------------------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Selection of a table view cell invokes a segue with the cell as a sender
        // This way we distiguish between all the other segues and the one to the SimulationViewController, assigning the view controller to the vc variable at the same time
        if let vc = segue.destinationViewController as? SimulationViewController,
        cell = sender as? UITableViewCell,
            indexPath = tableView.indexPathForCell(cell) {
            vc.configuration = items[indexPath.row]
            vc.configurationIndex = indexPath.row
            vc.delegate = self
        }
    }
    
    
    // This method is neccessary for receiving the unwind segue from the pushed view controllers
    @IBAction func unwindToInstrumentation(segue: UIStoryboardSegue) {
        
    }
    
    
    // -------------------------------------------------------------------------------
    // MARK: - SimulationViewControllerDelegate
    // -------------------------------------------------------------------------------
    
    func didSaveConfiguration(configuration: Configuration, atIndex index: Int) {
        // Replace the selected configuration with a new one and reload the tableView
        items.removeAtIndex(index)
        items.insert(configuration, atIndex: index)
        tableView.reloadData()
    }
}
