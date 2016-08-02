//  PersistenceService.swift



import UIKit

class PersistenceService {
    static let sharedInstance = PersistenceService()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var numberOfRows : Int {
        get {
            return self.defaults.integerForKey("def_numberOfRows")
        }
        set {
            self.defaults.setInteger(newValue, forKey: "def_numberOfRows")
        }
    }
    var numberOfCollumns : Int {
        get {
            return self.defaults.integerForKey("def_numberOfCollumns")
        }
        set {
            self.defaults.setInteger(newValue, forKey: "def_numberOfCollumns")
        }
    }
    var refreshRate : Double {
        get {
            return self.defaults.doubleForKey("def_refreshRate")
        }
        set {
            self.defaults.setDouble(newValue, forKey: "def_refreshRate")
        }
    }
    var timedRefresh : Bool {
        get {
            return self.defaults.boolForKey("def_timedRefresh")
        }
        set {
            self.defaults.setBool(newValue, forKey: "def_timedRefresh")
        }
    }
}
