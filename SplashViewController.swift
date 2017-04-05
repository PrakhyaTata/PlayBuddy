//
//  SplashViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/4/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SplashViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Initial")
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
         dispatch_after(time, dispatch_get_main_queue()) {
            
        
                FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if user != nil {
                        print("test")
                        // User is signed in.
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("tabbar")
                        self.presentViewController(nextViewController, animated: true, completion: nil)
                    } else {
                        print("test3")
                        // No user is signed in.
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("firstNavigationController")
                        self.presentViewController(nextViewController, animated: true, completion: nil)
                    }
                }
      }
        
     }

    
}
