//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 25/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginUserNameTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var loading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.loginButton.isEnabled = !self.loading;
                self.activityIndicator.isHidden = !self.loading;
                if self.loading {
                    self.activityIndicator.startAnimating();
                } else {
                    self.activityIndicator.stopAnimating();
                }
            }
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: AnyObject) {
        guard let email = loginUserNameTextField.text, email.characters.count > 0 else {
            showErrorAlert("Email should not be blank");
            return;
        }
        guard let password = loginPasswordTextField.text, password.characters.count > 0 else {
            showErrorAlert("Password should not be blank");
            return;
        }
        
        login(email, password);
    }
    
    func login(_ email: String, _ password: String) {
        loading = true;
        UdacityClient.sharedInstance().loginToUdacity(username: email, password: password){
            (result, success, error) in
            self.loading = false;
            if success {
                print(result);
                if let account_details = result?["account"] as? [String:AnyObject] {
                    let key = account_details["key"]!
                    User.uniqueKey = key as! String
                    User.email = email
                    self.loginSuccess()
                }else{
                    self.showErrorAlert("Unable to login");
                }
            }else {
                self.loginError(error)
            }
        }
    }

    func loginError(_ error: NSError?) -> Void {
        DispatchQueue.main.async {
            self.loginPasswordTextField.text = ""
            let message = error?.localizedDescription ?? "Unable to login";
            self.showErrorAlert(message)
        }
    }

    private func loginSuccess(){
        performUIUpdatesOnMain {
            UIApplication.shared.keyWindow?.rootViewController = OnTheMapViewController();
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginUserNameTextField {
            loginPasswordTextField.becomeFirstResponder()
        } else if textField == loginPasswordTextField {
            textField.resignFirstResponder()
            loginButton.sendActions(for: .touchUpInside)
        }
        return true
    }
}
