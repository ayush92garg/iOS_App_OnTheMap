//
//  UIViewControllerExtension.swift
//  On The Map
//
//  Created by Ayush Garg on 08/01/17.
//  Copyright © 2017 Headmaster Technologies. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(_ message: String) {
        showAlert("Uh-Oh", message);
    }
    
    func showAlert(_ title: String?, _ message: String, _ handler: ((UIAlertAction) -> Void)? = nil) {
        var handler = handler
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if handler == nil {
            handler = { (action) in
                alertView.dismiss(animated: true, completion: nil);
            }
        }
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler);
        alertView.addAction(action);
        DispatchQueue.main.async {
            self.present(alertView, animated: true, completion: nil);
        }
    }
    func showConfirmation(_ title: String?, _ message: String, _ confirmationHandler: ((UIAlertAction) -> Void)?) -> Void {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let confirmationAction = UIAlertAction(title: "Confirm", style: .destructive, handler: confirmationHandler);
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        alertView.addAction(confirmationAction);
        alertView.addAction(cancelAction);
        self.show(alertView, sender: nil);
    }
}
