//
//  ParseConstants.swift
//  On The Map
//
//  Created by Ayush Garg on 27/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

extension ParseClient {

    struct Constants {
        static let ApiName = "parse"
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
    }
    
    struct Credentals {
        static let ParseApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseRESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct Methods {
        static let fetchStudents = "/parse/classes/StudentLocation"
        static let updateStudent = "/parse/classes/StudentLocation"
    }
    
    struct StudentResult {
        static let results  =  "results"
        static let createdAt =  "createdAt"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let objectId = "objectId"
        static let uniqueKey = "uniqueKey"
        static let updatedAt = "updatedAt"
    }
    
}
