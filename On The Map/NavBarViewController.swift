//
//  NavBarViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 30/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit

class NavBarViewController: UIViewController, UINavigationBarDelegate {
    
    override func viewDidLoad() {
        navBar.topItem?.title = "On the Map"
    }
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var rightButton: UIBarButtonItem!
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
