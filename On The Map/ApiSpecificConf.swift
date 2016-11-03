//
//  ApiSpecificConf.swift
//  On The Map
//
//  Created by Ayush Garg on 27/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

extension NetworkingModule {
    
    func getHeaders(forApi: String, httpMethod: String) -> [String: String]? {
    
        var apiConf = [String : String]()
        
        switch (forApi, httpMethod) {
        case ("udacity","POST"):
            apiConf["Accept"] = "application/json"
            apiConf["Content-Type"] = "application/json"
            break
        case ("udacity","GET"):
            apiConf = [:]
            break
        case ("parse","GET"):
            apiConf["X-Parse-Application-Id"] = ParseClient.Credentals.ParseApplicationId
            apiConf["X-Parse-REST-API-Key"] = ParseClient.Credentals.ParseRESTAPIKey
            break
        case ("parse","PUT"):
            apiConf["X-Parse-Application-Id"] = ParseClient.Credentals.ParseApplicationId
            apiConf["X-Parse-REST-API-Key"] = ParseClient.Credentals.ParseRESTAPIKey
            apiConf["Content-Type"] = "application/json"
            break
        default:
            apiConf = [:]
        }
        return apiConf
    }
}
