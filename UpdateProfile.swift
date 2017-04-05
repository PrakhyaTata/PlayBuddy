//
//  UpdateProfile.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/2/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase

class UpdateProfile: UIViewController {
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        self.navigationItem.title = "Update Profile"
         self.hideKeyboardWhenTappedAround()
        emailUpdate()
    }

    
    @IBAction func LogoutItem(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewControllerWithIdentifier("firstNavigationController") as! UINavigationController
            self.presentViewController(vc, animated: false, completion: nil)
        }

        
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var number: UITextField!

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func emailUpdate() {
        
      //  let user =  FIRAuth.auth()?.currentUser
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        let databaseref = FIRDatabase.database().reference()
        var email:String = ""
        databaseref.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: {  snapshot in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                email = (dictionary["EmailID"] as? String)!
                print(email)
                print("checking email")
                self.email.text = email
            }
        })
        
        print(email)
        
    }
    
    
    @IBAction func update(sender: AnyObject) {
        if(((self.name.text)!.isEmpty) || ((self.number.text)!.isEmpty) || ((self.password.text)!.isEmpty))
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter all the fields ", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
            
            
        else
            
        {
        
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        
        let user =  FIRAuth.auth()?.currentUser
        
        let databaseref = FIRDatabase.database().reference()
        databaseref.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: {  snapshot in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = self.name.text!
                let number = self.number.text!
                let email = (dictionary["EmailID"] as? String)!
                var Sportdetails:String = " "
                var Timingsdetails:String = " "
                var zipcodedetails:String = " "
                let password = self.password.text!
                user?.updatePassword(password, completion: { (error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                })
                databaseref.child("Users").child(userID).setValue(["Name": name,"ContactNumber": number,  "EmailID": email ])
                
                databaseref.child("Users").child(userID).child("details").observeSingleEventOfType(.Value, withBlock: {  snapshot in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        print((dictionary["Sportdetails"] as? String)!)
                        
                        if((((dictionary["Sportdetails"] as? String))!.isEmpty))
                        {
                            Sportdetails = "empty"
                        }
                        else
                        {
                            Sportdetails = (dictionary["Sportdetails"] as? String)!
                        }
                        if((((dictionary["Timingdetails"] as? String))!.isEmpty))
                        {
                            Timingsdetails = "empty"
                        }
                        else{
                            Timingsdetails = (dictionary["Timingdetails"] as? String)!
                        }
                        if((((dictionary["zipcodedetails"] as? String))!.isEmpty))
                        {
                            zipcodedetails = "empty"
                        }
                        else{
                            zipcodedetails = (dictionary["zipcodedetails"] as? String)!
                        }
                    }
                })
                
                databaseref.child("Users").child(userID).child("details").setValue(["Sportdetails":Sportdetails,"Timingdetails":Timingsdetails,"zipcodedetails":zipcodedetails ])
            }
            }, withCancelBlock: nil)
        
        
        let alertController = UIAlertController(title: "Updated!", message: "Your details have been updated.", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    }

    @IBAction func Delete(sender: AnyObject) {
        
        let user =  FIRAuth.auth()?.currentUser
        user?.deleteWithCompletion({ (error) in
            if let error = error{
                print(error.localizedDescription)
            }
                
            else {
                let alertController = UIAlertController(title: "Deleted!", message: "Your account has been deleted.", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("playbuddy")
                self.presentViewController(nextViewController, animated: true, completion: nil)
                
            }
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewControllerWithIdentifier("firstNavigationController") as! UINavigationController
            self.presentViewController(vc, animated: false, completion: nil)
        }
    }
    
    }
    
    
    

    

