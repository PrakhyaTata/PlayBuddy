//
//  ViewController.swift
//  Play Buddy
//
//  Created by Soni Mamidi on 11/28/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var PlayBuddy: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        self.navigationItem.title = "Sign In!"
        self.hideKeyboardWhenTappedAround()
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    @IBAction func signInAction(sender: AnyObject) {
        
        
        if(self.email.text != "" && self.password.text != ""){
        FIRAuth.auth()?.signInWithEmail(email.text! , password: password.text!, completion: { (user, error) in
            if error == nil
            {
                
                print("login successful")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("tabbar")
                
                self.presentViewController(nextViewController, animated: true, completion: nil)
            }
                
            else {
                
                let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                print("Error: \(error)")
                 }
            
        })
            
        }
        
        else
            {
                let alertController = UIAlertController(title: "Oops!", message: "Both email and passord should be present", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.presentViewController(alertController, animated: true, completion: nil)
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



