//
//  SendMessageViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/3/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class SendMessageViewController: UIViewController,MFMessageComposeViewControllerDelegate {

    
   
    
    @IBOutlet var phone: UITextField!
     var contactnumber:String = ""
        
    @IBOutlet var textofmessage: UITextView!
 
    override func viewDidLoad() {
       
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
            self.navigationItem.title = "Send Message"
         self.hideKeyboardWhenTappedAround()
        

        phonenumber()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func phonenumber() {
        
    self.phone.text = contactnumber
        print(contactnumber)
    
    }
    
    
    @IBAction func SendMessage(sender: AnyObject) {
        
        if (MFMessageComposeViewController.canSendText()){
            let controller = MFMessageComposeViewController()
            controller.body = self.textofmessage.text
            controller.recipients = [self.phone.text!]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            let alertController = UIAlertController(title: "SEnt!", message: "Your message has been sent.", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
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
