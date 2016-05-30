//
//  Recoverable.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 5/26/16.
//
//

import UIKit

public extension UIAlertController {    
    /** 
    Creates and returns a view controller for displaying an alert to the user. (You will get the warning about deallocating, read more here: http://stackoverflow.com/questions/33805197/extension-uialertcontroller-convenience-init-warning)
     
    - Parameter error: error to populate this alert
        - title: get from localizedDescription, `NSLocalizedDescriptionKey` in error's userInfo
        - message: get from localizedFailureReason and localizedRecoverySuggestion, `NSLocalizedFailureReasonErrorKey` and `NSLocalizedRecoverySuggestionErrorKey` in error's userInfo
        - action titles: populate from localizedRecoveryOptions, `NSLocalizedRecoveryOptionsErrorKey` in error's userInfo
        - action handlers: populate from recoveryAttempter, `NSRecoveryAttempterErrorKey` in error's userInfo
    
    - Returns: An initialized alert controller object.
    */
    public convenience init(error: NSError) {
        // Extract title and message
        var messages = [String]()
        
        if let localizedFailureReason = error.localizedFailureReason {
            messages.append(localizedFailureReason)
        }
        
        if let localizedRecoverySuggestion = error.localizedRecoverySuggestion {
            messages.append(localizedRecoverySuggestion)
        }
        
        let message = messages.joinWithSeparator(" ")
        
        self.init(title: error.localizedDescription, message: message, preferredStyle: .Alert)
        
        if let recoveryAttempter = error.recoveryAttempter as? ErrorRecoveryAttempter {
            if let localizedRecoveryOptions = error.localizedRecoveryOptions {
                for (index, localizedRecoveryOption) in localizedRecoveryOptions.enumerate() {
                    let action = UIAlertAction(title: localizedRecoveryOption, style: .Default, handler: { (action) in
                        recoveryAttempter.attemptRecoveryFromError(error, optionIndex: index)
                    })
                    
                    self.addAction(action)
                }
            } else {
                // OK action for no recovery options
                let okTitle = NSLocalizedString("com.sarunw.error-recovery.ok", value: "OK", comment: "Alert ok action")
                let ok = UIAlertAction(title: okTitle, style: .Default, handler: nil)
                self.addAction(ok)
            }
        } else {
            // OK action for no recovery options
            let okTitle = NSLocalizedString("com.sarunw.error-recovery.ok", value: "OK", comment: "Alert ok action")
            let ok = UIAlertAction(title: okTitle, style: .Default, handler: nil)
            self.addAction(ok)
        }
    }
    
    /// Convenience method to add cancel action
    public func addCancelAction() {
        let cancelTitle = NSLocalizedString("com.sarunw.error-recovery.cancel", value: "Cancel", comment: "Alert cancel action")
        let cancel = UIAlertAction(title: cancelTitle, style: .Cancel, handler: nil)
        self.addAction(cancel)
    }
    
//    class public func alertController(fromError error: NSError) -> UIAlertController {
//        // Extract title and message
//        var messages = [error.localizedDescription]
//        if let localizedRecoverySuggestion = error.localizedRecoverySuggestion {
//            messages.append(localizedRecoverySuggestion)
//        }
//        let message = messages.joinWithSeparator("\n")
//        
//        let alert = UIAlertController(title: error.localizedDescription, message: message, preferredStyle: .Alert)
//        
//        if let recoveryAttempeter = error.recoveryAttempter as? ErrorRecoveryAttempter {
//            if let localizedRecoveryOptions = error.localizedRecoveryOptions {
//                for (index, localizedRecoveryOption) in localizedRecoveryOptions.enumerate() {
//                    let action = UIAlertAction(title: localizedRecoveryOption, style: .Default, handler: { (action) in
//                        recoveryAttempeter.attemptRecoveryFromError(error, optionIndex: index)
//                    })
//                    
//                    alert.addAction(action)
//                }
//                
//                // Add cancel action
//                let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//                alert.addAction(cancel)
//            } else {
//                let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
//                alert.addAction(ok)
//            }
//        }
//        
//        return alert
//    }
}