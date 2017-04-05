//
//  PasswordRecoveryViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/2/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PasswordRecoveryViewController: UIViewController {
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        self.navigationItem.title = "Password Recovery"
         self.hideKeyboardWhenTappedAround()
    }


    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func recoverButtonTapped(sender: AnyObject) {
        if self.userEmailTextField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        else {
            FIRAuth.auth()?.sendPasswordResetWithEmail(self.userEmailTextField.text!, completion: { (error) in
                var title = ""
                var message  = ""
                
                if error != nil{
                    
                    title = "Oops!";
                    message = (error?.localizedDescription)!
                    
                }
                else
                {
                    title = "sucess!"
                    message =  "Password reset email sent"
                    self.userEmailTextField.text = ""
                    
                }
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        
        
    }
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    
}
