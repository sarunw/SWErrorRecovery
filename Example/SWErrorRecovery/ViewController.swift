//
//  ViewController.swift
//  SWErrorRecovery
//
//  Created by Sarun Wongpatcharapakorn on 05/26/2016.
//  Copyright (c) 2016 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit
import SWErrorRecovery

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
        let recoveryAttempter = ErrorRecoveryAttempter()
        recoveryAttempter.addRecoveryOption(localizedTitle: "Open Settings") { () -> (Bool) in
            print("Recovered")
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            return true
        }        
        
        let info = [NSLocalizedDescriptionKey: "Motion & Fitness disabled",
                    NSLocalizedFailureReasonErrorKey: "You don't grant Motion & Fitness permission.",
                    NSLocalizedRecoverySuggestionErrorKey: "Please open this app's settings and turn on \"Motion & Fitness\".",
                    NSLocalizedRecoveryOptionsErrorKey: recoveryAttempter.recoveryOptions,
                    NSRecoveryAttempterErrorKey: recoveryAttempter]
        
        let error = NSError(domain: "error.domain", code: 0, userInfo: info)        
        let alert = UIAlertController(error: error)
        alert.addCancelAction()
        
        self.presentViewController(alert, animated: true) {
            
        }
    }
}

