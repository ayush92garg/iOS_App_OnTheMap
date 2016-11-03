//
//  UdacityClient.swift
//  On The Map
//
//  Created by Ayush Garg on 26/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

class UdacityClient : NSObject{
    
    struct useInfo {
        var userId: String? = nil
        var password: String? = nil
        var sessionID: String? = nil
        var uniqueKey: String? = nil
    }
    
    let session = URLSession.shared
    let oNetMod = NetworkingModule()
    let host = Constants.ApiHost
    let scheme = Constants.ApiScheme
    let name = Constants.ApiName
    
    override init() {
        super.init()
    }
    
    func loginToUdacity(username: String?, password: String?, completionOnLogin:@escaping (_ result: AnyObject?, _ success: Bool, _ error: NSError?) -> Void) {
        
        func sendError(error: String) {
            let errorInfo = [NSLocalizedDescriptionKey : error]
            completionOnLogin(nil, false, NSError(domain: "loginToUdacity", code: 1, userInfo: errorInfo))
        }
        
        //Guard for nil username
        guard let username = username, username != "" else {
            sendError(error: "User name is empty!")
            return
        }
        //Guard for nil passowrd
        guard let password = password, password != "" else {
            sendError(error: "Password is empty!")
            return
        }
        
        let method = Methods.getSessionMethod
        let jsonStringForLogin: String = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        
        oNetMod.postMethodTask(apiName: name ,apiScheme: scheme, apiHost: host, apiMethod: method,query_params: nil, jsonBody: jsonStringForLogin) {(result, error) in
            if result != nil {
                completionOnLogin(result, true, nil)
            }else{
                sendError(error: "Unable to login")
            }
        }
    }

    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
