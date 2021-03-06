//
//  StudentListTableViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 08/01/17.
//  Copyright © 2017 Headmaster Technologies. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {

    let reuseIdentifier = "studentCell";
    
    var studentData = [Students] () {
        didSet {
            self.tableView.reloadData();
        }
    }
    
    // MARK: - Table view data source

    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        (parent?.parent as? OnTheMapViewController)?.setupNavigationView(self);
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentData.count;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentData[indexPath.row]
        guard let url = student.mediaURL,
            let nsurl = NSURL(string: url) as? URL
            else {return;}
        UIApplication.shared.open(nsurl, options: [:], completionHandler: nil);
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        let student = studentData[indexPath.row]
        
        let fname = student.firstName ?? "";
        let lname = student.lastName ?? "";
        
        cell.textLabel?.text = fname + " " + lname
        cell.imageView?.image = UIImage(named: "map")
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
