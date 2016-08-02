//  UIAlertController+SimpleAlert.swift



import UIKit

extension UIViewController {
    
    // Getting the view controller from the top of the view hierarchy
    static func topMostController() -> UIViewController {
        
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        var topController: UIViewController = delegate!.window!.rootViewController!
        while topController.presentedViewController != nil && topController.presentedViewController?.isKindOfClass(UIAlertController) == false {
            topController = topController.presentedViewController!
        }
        if (topController.isKindOfClass(UINavigationController)) {
            topController = ((topController as! UINavigationController)).topViewController!
        }
        return topController
    }
}

extension UIAlertController {
    
    // Convenience method for creating a simple alert with an OK button
    static func okAlertWithTitle(title: String, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        
        return alertController
    }
    
    // Alert with presentation from the view controller on the top of the view hierarchy
    static func presentOKAlertWithTitle(title: String, message: String?) -> UIAlertController {
        let alertController = UIAlertController.okAlertWithTitle(title, message: message)
        UIViewController.topMostController().presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    
    // Convenience method for getting alert properties
    static func presentOKAlertWithError(error: NSError) -> UIAlertController {
        return presentOKAlertWithTitle("Error", message: error.domain)
    }
}
