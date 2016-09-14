//
//  ErrorRecoveryAttempter.swift
//  Pods
//
//  Created by Sarun Wongpatcharapakorn on 5/26/16.
//
//

import Foundation

/// Implementaion of `NSErrorRecoveryAttempting` informal protocol
open class ErrorRecoveryAttempter: NSObject {
    /**
    A block object to be executed when recover from error. This block taking no argument and return a Boolean that indicates whether or not the recovery was successful.
    */
    public typealias RecoveryBlock = () -> (Bool)
    public typealias CancelBlock = () -> ()
    
    fileprivate var titles = [String]()
    fileprivate var blocks = [RecoveryBlock]()
    
    fileprivate var cancelTitle: String?
    fileprivate var cancelBlock: CancelBlock?
    
    /// Extract the recovery options for use as `NSLocalizedRecoveryOptionsErrorKey`.
    open var recoveryOptions: [String] {
        return self.titles
    }
    
    open var cancelOption: String? {
        return self.cancelTitle
    }
    
    /**
    Build up the recovery options.
     
    - Parameter localizedTitle: localized string for use as `NSLocalizedRecoveryOptionsErrorKey`.
    - Parameter recoveryBlock: block that would be execute when user select this recovery option.
    */
    open func addRecoveryOption(localizedTitle title: String, recoveryBlock block: @escaping RecoveryBlock) {
        self.titles.append(title)
        self.blocks.append(block)
    }
    
    /**
     Cancel option
     
     - Parameter localizedTitle: localized string for use as `NSLocalizedRecoveryOptionsErrorKey`, default to Cancel.
     - Parameter recoveryBlock: block that would be execute when user select this recovery option.
     */
    open func addCancelOption(localizedTitle title: String? = NSLocalizedString("com.sarunw.error-recovery.cancel", value: "Cancel", comment: "Alert cancel action"), recoveryBlock block: CancelBlock? = nil) {
        self.cancelTitle = title
        self.cancelBlock = block
    }
    
    // MARK: - NSErrorRecoveryAttempting
    open override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int) -> Bool {
        return self.recover(optionIndex: recoveryOptionIndex)
    }
    
    // MARK: - NSErrorRecoveryAttempting
    open func cancelRecoveryFromError(_ error: NSError) -> Bool {
        self.cancelBlock?()
        return false
    }

    /**
    Given that an error alert has been presented document-modally to the user, and the user has chosen one of the error's recovery options, attempt recovery from the error, and send the selected message to the specified delegate. The option index is an index into the error's array of localized recovery options. The method selected by didRecoverSelector must have the same signature as:
     
     `(void)didPresentErrorWithRecovery:(BOOL)didRecover contextInfo:(void *)contextInfo;`
     The value passed for didRecover must be YES if error recovery was completely successful, NO otherwise.
    */
//    open override func attemptRecovery(fromError error: Error, optionIndex recoveryOptionIndex: Int, delegate: Any?, didRecoverSelector: Selector?, contextInfo: UnsafeMutableRawPointer?) {
//        
//        let didRecover = self.recover(optionIndex: recoveryOptionIndex)
//        let context = UnsafeMutablePointer<AnyObject>(contextInfo!)
//        
//        delegate?.perform(didRecoverSelector, with: didRecover, with: context.pointee)
//    }
    
    // MARK: - Private
    /**
    Recover from error based on option selected.
    
    - Parameter optionIndex: recovery option index.
    
    - Returns: YES if error recovery was completely successful, NO otherwise.
    */
    fileprivate func recover(optionIndex recoveryOptionIndex: Int) -> Bool {
        return self.blocks[recoveryOptionIndex]()
    }
}
