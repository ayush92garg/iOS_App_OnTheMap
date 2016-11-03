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
    
    var numberOfStudents: Int!
    var studentData: [Students] = [Students]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")!
        let student = studentData[indexPath.row]
        
        cell.textLabel?.text = student.firstName! + " " + student.lastName!
        cell.imageView?.image = UIImage(named: "map")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentData[indexPath.row]
        UIApplication.shared.openURL(NSURL(string: student.mediaURL!) as! URL)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        oParseClient.fetchStudentsData(forNumberOfStudents: 4, inAscending: false, pagesToSkip: nil){(data, success, error) in
            if success {
                if let data = data?["results"] as? [[String:AnyObject]]{
                    self.studentData = Students.studentsFromResults(results: data)
                }
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }

}
