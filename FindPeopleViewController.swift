//
//  FindPeopleViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/1/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FindPeopleViewController: UIViewController {
    
    var model = Findpeoplemodel()
    override func viewDidLoad() {
        self.navigationItem.title = "Find People"
        let barbutton = UIBarButtonItem()
        barbutton.title = "Back"
        self.navigationItem.backBarButtonItem = barbutton
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)

         self.hideKeyboardWhenTappedAround()
    }


    
    
    @IBOutlet weak var sport: UITextField!
    
    @IBOutlet weak var timings: UITextField!

    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var findbutton: UIButton!
    
    @IBOutlet weak var dropDown: UIPickerView!
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return model.list.count
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        self.view.endEditing(true)
        return model.list[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.sport.text = self.model.list[row]
        self.dropDown.hidden = true
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == self.sport {
            self.dropDown.hidden = false
        
            
            textField.endEditing(true)
        }
        
        
    }
    
    
    
    @IBAction func FindPeople(sender: AnyObject) {
      
        if(((self.sport.text)!.isEmpty) || ((self.timings.text)!.isEmpty) || ((self.zipcode.text)!.isEmpty))
        {
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter all the fields ", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
    
        }
    
    
    else
    
    {
        let userID = (FIRAuth.auth()?.currentUser?.uid)!
        
            let databaseref = FIRDatabase.database().reference()
            databaseref.child("Users").child(userID).observeSingleEventOfType(.Value, withBlock: {  snapshot in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                  let  name = (dictionary["Name"] as? String)!
                   let email = (dictionary["EmailID"] as? String)!
                   let number = (dictionary["ContactNumber"] as? String)!
                    
               

            let Sportdetails = self.sport.text!
            let Timingsdetails = self.timings.text!
            let zipcodedetails = self.zipcode.text!
            databaseref.child("Users").child(userID).setValue([ "Name":name,"EmailID":email,"ContactNumber":number, "Sportdetails":Sportdetails,"Timingdetails":Timingsdetails,"zipcodedetails":zipcodedetails])
                }
            
            }, withCancelBlock: nil)
        
            self.performSegueWithIdentifier("findpeopletolist", sender: self)
    
    }
        
    }
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
                if (segue.identifier == "findpeopletolist") {
        
                    let svc = segue!.destinationViewController as! ListOfPeopleViewController;
        
                    svc.sport = self.sport.text!
                    
                    
                    
                }

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
