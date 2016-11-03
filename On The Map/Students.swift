//
//  Students.swift
//  On The Map
//
//  Created by Ayush Garg on 27/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

struct Students{
    var createdAt : String?
    var firstName : String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
    
    
    init(dictionary: [String:AnyObject]) {
        createdAt = (dictionary[ParseClient.StudentResult.createdAt] as? String)
        firstName = (dictionary[ParseClient.StudentResult.firstName] as? String)
        lastName = (dictionary[ParseClient.StudentResult.lastName] as? String)
        latitude = (dictionary[ParseClient.StudentResult.latitude] as? Double)
        longitude = (dictionary[ParseClient.StudentResult.longitude] as? Double)
        mapString = (dictionary[ParseClient.StudentResult.mapString] as? String)
        mediaURL = (dictionary[ParseClient.StudentResult.mediaURL] as? String)
        objectId = (dictionary[ParseClient.StudentResult.objectId] as? String)
        uniqueKey = (dictionary[ParseClient.StudentResult.uniqueKey] as? String)
        updatedAt = (dictionary[ParseClient.StudentResult.updatedAt] as? String)
    }
    
    static func studentsFromResults(results: [[String:AnyObject]]) -> [Students] {
        
        var studentsData = [Students]()
        
        // iterate through array of students, each Student is a dictionary
        for result in results {
            studentsData.append(Students(dictionary: result))
        }
        return studentsData
    }

}
