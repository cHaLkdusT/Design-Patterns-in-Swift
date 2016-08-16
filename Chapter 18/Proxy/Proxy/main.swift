//
//  main.swift
//  Proxy
//
//  Created by jlundang on 03/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

let url = "http://localhost"

let headers = ["Keep-Alive", "Connection"]
let proxy = AccessControlProxy(url: url)
for header in headers {
    proxy.getHeader(header, callback: { (header, val) in
        if let _ = val {
            print("\(header): \(val!)")
        }
    })
}
UserAuthentication.sharedInstance.authenticated("bob", pass: "secret")
proxy.execute()
NSFileHandle.fileHandleWithStandardInput().availableData