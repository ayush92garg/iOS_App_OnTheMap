//
//  TableViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 26/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit

class TableViewController: NavBarViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")!
        let student = studentData[indexPath.row]
        
        let fname = student.firstName ?? "";
        let lname = student.lastName ?? "";
        
        cell.textLabel?.text = fname + " " + lname
        cell.imageView?.image = UIImage(named: "map")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentData[indexPath.row]
        guard let url = student.mediaURL,
            let nsurl = NSURL(string: url) as? URL
            else {return;}
        UIApplication.shared.open(nsurl, options: [:], completionHandler: nil);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        oParseClient.fetchStudentsData(forNumberOfStudents: 100, inAscending: false, pagesToSkip: 0){(data, success, error) in
//            if success {
//                if let data = data?["results"] as? [[String:AnyObject]]{
//                    self.studentData = Students.studentsFromResults(results: data)
//                }
//                self.tableView.reloadData()
//            }
//        }
        tableView.reloadData()
    }

}
