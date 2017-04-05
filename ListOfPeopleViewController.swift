//
//  ListOfPeopleViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/2/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListOfPeopleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var listmodel = ListModel()
    
    @IBOutlet var ListTable: UITableView!
    
    
    var sport:String = ""
    
    var user:String = ""
   
    var username:String = ""
    
    var nameofuser:String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.ListOfPeople(listmodel.item)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
       
            self.navigationItem.title = "List of People"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    var id:[String] = []
    
    
    
    //to find list of people intersted in same sport by quering in firebase
           func ListOfPeople(items:Array<String>) -> Array<String>{
        
           var localArray:[String] = []
        
           let userID = (FIRAuth.auth()?.currentUser?.uid)!
        
           let ref = FIRDatabase.database().reference()
           ref.child("Users").child(userID).child("details").observeSingleEventOfType(.Value, withBlock: {  snapshot in
            
           if let dictionary = snapshot.value as? [String: AnyObject] {
           print(dictionary)
           self.sport = (dictionary["Sportdetails"] as? String)!
            
            }
            },withCancelBlock: nil)
        
        
            ref.childByAppendingPath("Users")
            .observeEventType(.Value, withBlock: { snapshot in
                 print(snapshot)
       
            for child in snapshot.children {
//                print("snapshot")
//                print(snapshot)
            let name = child.value["Name"] as! NSString
            localArray.append(name as String)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.ListTable.reloadData()
                })
                print(localArray)
                print(self.listmodel.item)
                
                
                
              if localArray.isEmpty {
                    
              let alertController = UIAlertController(title: "Oops!", message: "List Empty", preferredStyle: .Alert)
              let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
              alertController.addAction(defaultAction)
              self.presentViewController(alertController, animated: true, completion: nil)
                
                }
                
                self.listmodel.item =  localArray
                print(self.listmodel.item)
                print(self.self.listmodel.item.count)
                
            })
               return items
        
    }

        // rows printing
              func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              print(self.listmodel.item)
              return self.listmodel.item.count
        
    }
    
    // table cell value
            func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            cell.textLabel?.text = listmodel.item[indexPath.row]
            return cell
        
    }
    
           func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath){
           let cell = ListTable.cellForRowAtIndexPath(indexPath)
           self.performSegueWithIdentifier("todetails", sender: cell)
       
   }
    
 
    
          override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
          let cell = sender as! UITableViewCell
          if (segue.identifier == "todetails") {
          self.nameofuser = self.listmodel.item[(ListTable.indexPathForCell(cell)?.row)!]
          let svc1 = segue!.destinationViewController as! PersonDetailsViewController;
          print(self.nameofuser)
          print("fromlist")
          svc1.namefromlist = self.nameofuser
            
        }
        
    }

    
    
          @IBAction func logout(sender: AnyObject) {
          try! FIRAuth.auth()!.signOut()
          if let storyboard = self.storyboard {
          let vc = storyboard.instantiateViewControllerWithIdentifier("firstNavigationController") as! UINavigationController
          self.presentViewController(vc, animated: false, completion: nil)
        }
    }
    
    
}


