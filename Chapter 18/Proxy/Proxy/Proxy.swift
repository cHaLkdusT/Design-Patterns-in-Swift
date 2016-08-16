//
//  HttpRequestHeader.swift
//  Proxy
//
//  Created by jlundang on 04/08/2016.
//  Copyright © 2016 15th Team. All rights reserved.
//

import Foundation

protocol HttpHeaderRequest {
    init(url: String)
    func getHeader(header: String, callback: (String, String?) -> Void)
    func execute()
}

class AccessControlProxy: HttpHeaderRequest {
    private let wrappedObject: HttpHeaderRequest
    
    required init(url: String) {
        wrappedObject = HttpHeaderRequestProxy(url: url)
    }
    
    func getHeader(header: String, callback: (String, String?) -> Void) {
        wrappedObject.getHeader(header, callback: callback)
    }
    
    func execute() {
        if UserAuthentication.sharedInstance.authenticated {
            wrappedObject.execute()
        } else {
            fatalError("Unauthorized")
        }
    }
}

private class HttpHeaderRequestProxy : HttpHeaderRequest {
    let url: String
    var headersRequired: [String: (String, String?) -> Void]
    
    required init(url: String) {
        self.url = url
        self.headersRequired = Dictionary<String, (String, String?) -> Void>()
    }
    
    private let queue = dispatch_queue_create("httpQ", DISPATCH_QUEUE_SERIAL)
    private let semaphore = dispatch_semaphore_create(0)
    private var cacheHeaders = [String: String]()
    
    func getHeader(header: String, callback: (String, String?) -> Void) {
        self.headersRequired[header] = callback
    }
    
    func execute() {
        let nsUrl = NSURL(string: url)
        let request = NSURLRequest(URL: nsUrl!)
        NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            if let httpResponse = response as? NSHTTPURLResponse {
                let headers = httpResponse.allHeaderFields as! [String: String]
                for (header, callback) in self.headersRequired {
                    callback(header, headers[header])
                }
            }
        }.resume()
    }
}

