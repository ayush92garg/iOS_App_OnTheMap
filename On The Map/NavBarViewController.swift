//
//  NavBarViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 30/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit

class NavBarViewController: UIViewController, UINavigationBarDelegate {
    
    var studentData: [Students] = [Students]();
    
    override func viewDidLoad() {
        navBar.topItem?.title = "On the Map"
    }
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    let oParseClient = ParseClient()

    @IBAction func updateUserInfoButtonIsClicked(){
        let locationExists = oParseClient.userLocationExists(studentUniqueKey: User.uniqueKey)
        if locationExists {
            showAlert()
        }else{
            showUpdateVC()
        }
    }

    @IBAction func logoutButtonIsClicked(){
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.udacity.com/api/session")! as URL)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                print("error in logging out")
                return
            }
            let range = 5...Int((data?.count)!)
            let newData = data?.subdata(in: Range(range))
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
//            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue))
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! UIViewController
//            self.present(controller, animated: true, completion: nil)
        }
        task.resume()
    }
    
    
    public func showAlert(){
        // create the alert
        let alert = UIAlertController(title: "Location Saved Already", message: "Would you like to overwrite the existing location", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.destructive, handler: {action in
                self.showUpdateVC()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showUpdateVC(){
        performSegue(withIdentifier: "updateLocation", sender: self)
   }

}
