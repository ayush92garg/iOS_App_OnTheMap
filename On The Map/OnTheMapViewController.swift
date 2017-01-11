//
//  OnTheMapViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 08/01/17.
//  Copyright © 2017 Headmaster Technologies. All rights reserved.
//

import UIKit

class OnTheMapViewController: UITabBarController {

    var studentData = [Students]();
    var loggedIn: Bool = false;
    weak var mapViewController: MapViewController?;
    weak var listViewController: StudentListTableViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData();
        setupViewControllers();
        selectedIndex = 0;
        // Do any additional setup after loading the view.
    }
    
    func setupViewControllers() {
        let mapViewController = MapViewController();
        let listViewController = StudentListTableViewController();
        viewControllers = [
            UINavigationController(rootViewController: mapViewController),
            UINavigationController(rootViewController: listViewController)
        ];
        self.mapViewController = mapViewController;
        self.listViewController = listViewController;
    }

    func setupNavigationView(_ viewController: UIViewController) {
        viewController.navigationItem.title = "On the Map";
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(OnTheMapViewController.logoutButtonPressed));
        let addUpdateLocationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(OnTheMapViewController.updateLocationButton));
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(OnTheMapViewController.getData));
        viewController.navigationItem.rightBarButtonItems = [addUpdateLocationButton, refreshButton];
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func getData(_ pageNumber: Int = 0) {
        let parseClient = ParseClient();
        parseClient.fetchStudentsData(forNumberOfStudents: 100, inAscending: false, pagesToSkip: pageNumber)
        {
            (data, success, error) in
            if success {
                if let data = data?["results"] as? [[String:AnyObject]]{
                    self.studentData = Students.studentsFromResults(results: data)
                    self.updateViews();
                }
            } else {
                self.showErrorAlert("Unable to fetch data from server");
            }
        }
    }

    func updateLocationButton() -> Void {
        let locationExists = ParseClient().userLocationExists(studentUniqueKey: User.uniqueKey)
        if locationExists {
            showConfirmation("Location Already Saved", "Would you like to overwrite the location?", { (action: UIAlertAction) in
            self.updateLocation();
            })
        } else {
            updateLocation();
        }
    }
    
    func updateLocation() -> Void {
        print("HELLO");
    }
    
    func updateViews() -> Void {
        mapViewController?.studentData = studentData;
        listViewController?.studentData = studentData;
    }

    func logoutButtonPressed() -> Void {
        UdacityClient().logout(self);
    }

    func logoutSuccess(){
        performUIUpdatesOnMain {
            self.showAlert(nil, "Logout Success", {(action)
                in
                UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.init(name: "OnTheMap", bundle: nil).instantiateInitialViewController();
            });
        }
    }
    
    func logoutFailed(_ error: Error) -> Void {
        showErrorAlert(error.localizedDescription );
    }
}
