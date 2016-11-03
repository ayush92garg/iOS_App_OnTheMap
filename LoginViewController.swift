//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 25/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var loginTextTop: NSLayoutConstraint!
    @IBOutlet weak var passwordTop: NSLayoutConstraint!
    var email: String? = nil
    var password: String? = nil
    
    
    @IBAction func loginButtonClicked(_ sender: AnyObject) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        email = loginNameTextField.text!
        password = passwordTextField.text!
        
        UdacityClient.sharedInstance().loginToUdacity(username: email, password: password){
            (result, success, error) in
            if success {
                if let account_details = result?["account"] as? [String:AnyObject] {
                    let key = account_details["key"]!
                    User.uniqueKey = key as! String
                    User.email = self.email!
                    self.login()
                }else{
                    self.activityIndicator.stopAnimating()
                    self.updateErrorLabel(errorString: "Unable to Login")
                }
            }else {
                self.activityIndicator.stopAnimating()
                self.passwordTextField.text = ""
                self.updateErrorLabel(errorString: "Invalid User Name/ Password")
            }
        }
    }

    func updateErrorLabel(errorString: String) {
            if self.errorLabel.isHidden {
                self.errorLabel.isHidden = false
            }
            self.errorLabel.text = errorString
    }
    
    private func login(){
        performUIUpdatesOnMain {
            self.performSegue(withIdentifier: "loginHomeSegue", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isHidden = true
        loginNameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.text = ""
        activityIndicator.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginNameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            textField.resignFirstResponder()
            loginButton.sendActions(for: .touchUpInside)
        }

        return true
    }
}
