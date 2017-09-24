//
//  TouchID.swift
//  Hyphenate-Demo-Swift
//
//  Created by David Li on 9/24/17.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//

import Foundation
import LocalAuthentication

class BiometricsAuthentication {
    
    func isAvailable() -> Bool {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            
            // Device can use TouchID
            return true
            
        } else {
            // Device cannot use TouchID
            /*
             switch error!.code {
             
             case LAError.Code.touchIDNotEnrolled.rawValue:
             notifyUser("TouchID is not enrolled",
             err: error?.localizedDescription)
             
             case LAError.Code.passcodeNotSet.rawValue:
             notifyUser("A passcode has not been set",
             err: error?.localizedDescription)
             LAError.Code.
             default:
             notifyUser("TouchID not available",
             err: error?.localizedDescription)
             }*/
            
            xcgLogger.debug("Error: \(error!)")
        }
        
        return false
    }
    
    /*
     func notifyUser(_ msg: String, err: String?) {
     let alert = UIAlertController(title: msg,
     message: err,
     preferredStyle: .alert)
     
     let cancelAction = UIAlertAction(title: "OK",
     style: .cancel, handler: nil)
     
     alert.addAction(cancelAction)
     
     self.present(alert, animated: true,
     completion: nil)
     }*/
    
    func authenticate(completion: @escaping (Error?) -> Void) {
        let context = LAContext()
        
        //var error: NSError?
        context.localizedFallbackTitle = ""
        
        context.evaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Please sign on",
            reply: {
                (success, error) in
                
                //DispatchQueue.main.async {
                
                if error != nil {
                    /*
                     switch error!._code {
                     
                     case LAError.Code.systemCancel.rawValue:
                     self.notifyUser("Session cancelled",
                     err: error?.localizedDescription)
                     
                     case LAError.Code.userCancel.rawValue:
                     self.notifyUser("Please try again",
                     err: error?.localizedDescription)
                     
                     case LAError.Code.userFallback.rawValue:
                     self.notifyUser("Authentication",
                     err: "Password option selected")
                     // Custom code to obtain password here
                     
                     default:
                     self.notifyUser("Authentication failed",
                     err: error?.localizedDescription)
                     }*/
                    xcgLogger.debug("Error: \(error!)")
                    completion(error)
                    
                } else {
                    //self.notifyUser("Authentication Successful",
                    //                err: "You now have full access")
                    xcgLogger.debug("You now have full access")
                    completion(nil)
                }
                //}
        })
    }
}
