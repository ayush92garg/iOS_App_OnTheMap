//
//  ParseClient.swift
//  On The Map
//
//  Created by Ayush Garg on 27/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    let session = URLSession.shared
    let oNetMod = NetworkingModule()
    let host = Constants.ApiHost
    let scheme = Constants.ApiScheme
    let name = Constants.ApiName
    
    override init() {
        super.init()
    }
    
    func fetchStudentsData(forNumberOfStudents: Int, inAscending: Bool, pagesToSkip :Int?, onCompletionOfFetch:@escaping (_ result : AnyObject?, _ success: Bool, _ error: NSError?) -> Void) {
        func sendError(error: String) {
            let errorInfo = [NSLocalizedDescriptionKey : error]
            onCompletionOfFetch(nil, false, NSError(domain: "fetchStudentsData", code: 1, userInfo: errorInfo))
        }
        
        
        //guard pages to skip should be greater than zero
        guard let pagesToSkip = pagesToSkip, pagesToSkip >= 0 else {
            sendError(error: "Invalid value for pages to skip")
            return
        }
        
        let method = Methods.fetchStudents
        var parameters = [String : AnyObject]()
        parameters["limit"] = forNumberOfStudents as AnyObject
        parameters["skip"] = pagesToSkip as AnyObject
        
        parameters["order"] = (inAscending) ? "updatedAt" as AnyObject : "-updatedAt" as AnyObject
        
        
        _ = oNetMod.getMethodTask(apiName: name, apiScheme: scheme, apiHost: host, apiMethod: method, query_params: parameters){(result, error) in
            if result != nil {
                onCompletionOfFetch(result, true, nil)
            }else{
                onCompletionOfFetch(nil, false, error)
            }
        }
        
    }
    
     func userLocationExists(studentUniqueKey: String) -> Bool {
        
        let method = Methods.fetchStudents
        var exists: Bool = true
        var queryParams = [String : AnyObject]()
        queryParams["where"] = "{\"uniqueKey\":\"\(studentUniqueKey)\"}" as AnyObject?
        _ = oNetMod.getMethodTask(apiName: name, apiScheme: scheme, apiHost: host, apiMethod: method, query_params: queryParams){(result, error) in
            
            guard error == nil else {
                return
            }
            
            if let result = result?["results"]{
                if result == nil {
                    exists = false
                }
            }
        }
        return exists
    }
    

    func updateStudentsData(completion: @escaping (_ result: AnyObject?,_ success: Bool, _ error: NSError?) -> Void ){
        let method = Methods.updateStudent
        let jsonString = "{\"uniqueKey\": \"\(User.uniqueKey)\", \"firstName\": \"Ayush\", \"lastName\": \"Garg\",\"mapString\": \"\(LocationDetails.locationString)\", \"mediaURL\": \"\(LocationDetails.mediaUrl)\",\"latitude\": \(LocationDetails.latitude!), \"longitude\": \(LocationDetails.longitude!)}"
        _ = oNetMod.putMethodTask(apiName: name, apiScheme: scheme, apiHost: host, apiMethod: method, query_params: nil, jsonBody: jsonString){(result, error) in
            if let error = error {
                completion(nil, false, error)
            }else{
                completion(result, true, nil)
            }
        }
    }
}
