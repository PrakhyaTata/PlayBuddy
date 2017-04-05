//
//  SignUpViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 11/29/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    var singup = SignUpModel()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        self.navigationItem.title = "Sign Up"
         self.hideKeyboardWhenTappedAround()
           }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func signUp(sender: AnyObject) {
        
        if(singup.isValidEmail(self.username.text!) && singup.isValidPhone(self.number.text!))
            
            {
        
                FIRAuth.auth()?.createUserWithEmail(self.username.text!, password: self.password.text!, completion: {
                (user, error) in
            
                        if error != nil {
                        print("Error"+(error?.localizedDescription)!)
                        }
                        else{
                        print("success")
            
                        let userID: String = user!.uid
                        let name: String = self.name.text!
                        let number: String = self.number.text!
                        let emailID: String = self.username.text!
                        let ref = FIRDatabase.database().reference()
                        ref.child("Users").child(userID).setValue(["Name": name,"ContactNumber": number,  "EmailID": emailID])
                
                        self.login()
                           
                            
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
    
    
    @IBAction func login(){
        
        
        if(self.username.text != "" && self.password.text != ""){
            FIRAuth.auth()?.signInWithEmail(username.text! , password: password.text!, completion: { (user, error) in
                if error == nil{
                       self.performSegueWithIdentifier("singuptotab", sender: self)
                   }
                else
                {
                    
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
