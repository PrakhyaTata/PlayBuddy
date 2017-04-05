//
//  PersonDetailsViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/2/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PersonDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var details:[String] = []
    
    var itemTaDa:String = ""
    
    @IBOutlet var detaillist: UITableView!
    
    var namefromlist:String = ""
    var email:String = ""
    var number:String = ""
    var zipcode:String = ""
    var timings:String = ""
    var userfinalname:String = ""
    var sport:String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
        
        self.navigationItem.title = "Details"
        
        self.hideKeyboardWhenTappedAround()
        
        print(namefromlist)
        
        self.detailsOfPerson(details)
        
        print("test")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var Sample:String = "Soni"
    
    func detailsOfPerson(items:Array<String>) -> Array<String>{
        
    let ref = FIRDatabase.database().reference()
    ref.child("Users").queryOrderedByChild("Name").queryEqualToValue(namefromlist)
    .observeEventType(.Value, withBlock: { snapshot in
        for child in snapshot.children {
                self.userfinalname = child.value["Name"] as! NSString as String
                self.details.append(self.userfinalname as String)

                self.email = child.value["EmailID"] as! NSString as String
                self.details.append(self.email as String)
                
                self.number = child.value["ContactNumber"] as! NSString as String
                 self.details.append(self.number as String)
  
                print(self.number)
                if((child.value["zipcodedetails"] as! NSString as String).isEmpty)
                {
                    self.zipcode = "empty"
                }
                
                else
                {
                    self.zipcode = (child.value["zipcodedetails"] as! NSString as String)
                }
                
                if((child.value["Sportdetails"] as! NSString as String).isEmpty)
                {
                self.zipcode = "empty"
                }
                else
                {
                self.zipcode = (child.value["Sportdetails"] as! NSString as String)
                }
                if((child.value["Timingdetails"] as! NSString as String).isEmpty)
                {
                self.zipcode = "empty"
                }
                else
                {
                self.zipcode = (child.value["Timingdetails"] as! NSString as String)
                }
            
                self.details.append(self.zipcode as String)
            
                self.details.append(self.sport as String)
            
                self.details.append(self.timings as String)
                print(self.details)
            
                }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.detaillist.reloadData()
                }
            )
            
    })
    
    
  return details
}

    @IBAction func Call(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: number)!)
        
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.details.count
    }
     
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.details[indexPath.row]
        
        return cell
    
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        
        if (segue.identifier == "tosendmessage") {
            
        let svc2 = segue!.destinationViewController as! SendMessageViewController;
            
        svc2.contactnumber = self.number
            
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