//
//  Auth.swift
//  Proxy
//
//  Created by jlundang on 05/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

class UserAuthentication  {
    var user: String?
    var authenticated = false
    
    private init() {
        // Do nothing - stops instances being created
    }
    
    func authenticated(user: String, pass: String) {
        if pass == "secret" {
            self.user = user
            self.authenticated = true
        } else {
            self.user = nil
            self.authenticated = false
        }
    }
    
    class var sharedInstance: UserAuthentication {
        get {
            struct SingletonWrapper {
                static let singleton = UserAuthentication()
            }
            return SingletonWrapper.singleton
        }
    }
}