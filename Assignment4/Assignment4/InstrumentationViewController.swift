//
//  InstrumentationViewController.swift
//  Assignment3
//
//  Created by Stephen Chang on 18/07/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberOfRowsTextField: UITextField!
    @IBOutlet weak var numberOfColumnsTextField: UITextField!
    @IBOutlet weak var numberOfRowsStepper: UIStepper!
    @IBOutlet weak var numberOfColumnsStepper: UIStepper!
    @IBOutlet weak var timedRefreshSwitch: UISwitch!
    @IBOutlet weak var refreshRateLabel: UILabel!
    
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
            StandardEngine.sharedInstance.scheduleTimer()
            PersistenceService.sharedInstance.refreshRate = newValue
            self.refreshUI()
        }
    }
    var timedRefresh : Bool {
        get {
            return PersistenceService.sharedInstance.timedRefresh
        }
        set {
            StandardEngine.sharedInstance.scheduleTimer()
            PersistenceService.sharedInstance.timedRefresh = newValue
            self.refreshUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
