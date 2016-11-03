//
//  NetworkingModule.swift
//  On The Map
//
//  Created by Ayush Garg on 26/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

class NetworkingModule :NSObject {
    
    let session = URLSession.shared
    
    func getMethodTask(apiName: String, apiScheme: String, apiHost: String, apiMethod: String, query_params: [String:AnyObject]?, completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask {

        //setting parameters
        let parameters = query_params
        var request = URLRequest(url: generateURL(withScheme: apiScheme, withHost: apiHost, withPath: apiMethod, withQueryStringParams: parameters) as URL)
        let apiSpecificParams = getHeaders(forApi: apiName, httpMethod: "GET")

        if let apiSpecificParams = apiSpecificParams {
            for(httpHeader, headerValue) in apiSpecificParams {
                request.addValue(headerValue, forHTTPHeaderField: httpHeader)
            }
        }

        //making request
        let task = session.dataTask(with: request){ (data, response, error) in
            func sendError(error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "gettMethodTask", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {

                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            //parse the data
            
//            let range = 5...Int(data.count)
//            let newData = data.subdata(in: Range(range))
            self.convertDataWithCompletionHandler(data: data as Data){(parsedResult, parsingError) in
                if parsedResult == nil {
                    completion(nil, parsingError)
                }else{
                    completion(parsedResult, nil)
                }
            }
        }
        
        //start the request
        task.resume()
        return task
    }
    
    func postMethodTask(apiName: String, apiScheme: String, apiHost: String, apiMethod: String, query_params: [String:AnyObject]?, jsonBody: String, completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask {
        //setting parameters
        let parameters = query_params
        var request = URLRequest(url: generateURL(withScheme: apiScheme, withHost: apiHost, withPath: apiMethod, withQueryStringParams: parameters) as URL)
        
        //configuring request and building URL
        request.httpMethod = "POST"
        let apiSpecificParams = getHeaders(forApi: apiName, httpMethod: "POST")

        if let apiSpecificParams = apiSpecificParams {
            for(httpHeader, headerValue) in apiSpecificParams {
                request.addValue(headerValue, forHTTPHeaderField: httpHeader)
            }
        }

        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        //making request
        let task = session.dataTask(with: request){ (data, response, error) in
            func sendError(error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "postMethodTask", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            //parse the data
            let range = 5...Int(data.count)
            let newData = data.subdata(in: Range(range))
            self.convertDataWithCompletionHandler(data: newData as Data){(parsedResult, parsingError) in
                if parsedResult == nil {
                    completion(nil, parsingError)
                }else{
                    completion(parsedResult, nil)
                }
                
            }
        }
        
        //start the request
        task.resume()
        return task
    }
    
    func putMethodTask(apiName: String, apiScheme: String, apiHost: String, apiMethod: String, query_params: [String:AnyObject]?, jsonBody: String, completion: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask {
        //setting parameters
        let parameters = query_params
        var request = URLRequest(url: generateURL(withScheme: apiScheme, withHost: apiHost, withPath: apiMethod, withQueryStringParams: parameters) as URL)
        
        //configuring request and building URL
        request.httpMethod = "POST"
        let apiSpecificParams = getHeaders(forApi: apiName, httpMethod: "PUT")
        
        if let apiSpecificParams = apiSpecificParams {
            for(httpHeader, headerValue) in apiSpecificParams {
                request.addValue(headerValue, forHTTPHeaderField: httpHeader)
            }
        }
        
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        //making request
        let task = session.dataTask(with: request){ (data, response, error) in
            func sendError(error: String) {                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "postMethodTask", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            //parse the data
            //let range = 5...Int(data.count)
            //let newData = data.subdata(in: Range(range))
            self.convertDataWithCompletionHandler(data: data as Data){(parsedResult, parsingError) in
                if parsedResult == nil {
                    completion(nil, parsingError)
                }else{
                    completion(parsedResult, nil)
                }
                
            }
        }
        
        //start the request
        task.resume()
        return task
    }
    
    
    //Function to generate URLs
    func generateURL(withScheme: String, withHost: String, withPath: String, withQueryStringParams: [String: AnyObject]?) -> NSURL {
        var urlComponents = URLComponents()
        urlComponents.scheme = withScheme
        urlComponents.host = withHost
        urlComponents.path = withPath
        urlComponents.queryItems = [NSURLQueryItem]() as [URLQueryItem]?
        if let withQueryStringParams = withQueryStringParams {
            for (key,value) in withQueryStringParams {
                let queryItem = URLQueryItem(name: key, value: String(describing: value))
                
                urlComponents.queryItems!.append(queryItem as URLQueryItem)
            }
        }
        return urlComponents.url! as NSURL
    }
    
    private func convertDataWithCompletionHandler(data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        
        var parsedResult: Any?
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data , options: .allowFragments)
        } catch let parseError{
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult as AnyObject?, nil)
    }
}
