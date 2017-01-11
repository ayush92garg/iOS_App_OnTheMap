//
//  DataHelper.swift
//  On The Map
//
//  Created by Ayush Garg on 08/01/17.
//  Copyright © 2017 Headmaster Technologies. All rights reserved.
//

import UIKit

class DataHelper: NSObject {
    class func getJSONString(FromJSONObject object: AnyObject) -> String {
        guard
            let data = getData(FromJSONObject: object),
            let JSONString = String(data: data, encoding: .utf8)
            else {return "";}
        return JSONString;
    }
    
    class func getData(FromJSONObject object: AnyObject) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: object, options: .init(rawValue: 0));
        } catch {
            // #TODO Handle This
        }
        return nil;
    }
}
