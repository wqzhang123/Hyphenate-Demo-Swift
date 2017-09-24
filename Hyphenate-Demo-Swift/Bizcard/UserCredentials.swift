//
//  UserCredentials.swift
//  Hyphenate-Demo-Swift
//
//  Created by David Li on 9/24/17.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//

import Foundation

// A sigleton
class UserCredentials {
    public static let instance = UserCredentials()
    
    //private var username = ""
    //private var password = ""
    
    private init() {}
    
    func save(username: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "Bizcardusername")
        defaults.set(password, forKey: "Bizcarduserpassword")
        defaults.synchronize()
    }
    
    func getLoginCredentials() -> (username: String, password: String)? {
        let defaults = UserDefaults.standard
        guard let username = defaults.string(forKey: "Bizcardusername"),
            let password = defaults.string(forKey: "Bizcarduserpassword") else {
            return nil
        }
        
        return (username: username, password: password)
    }
    
    func deleteLoginCredentials() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Bizcardusername")
        defaults.removeObject(forKey: "Bizcarduserpassword")
        defaults.synchronize()
    }
}
