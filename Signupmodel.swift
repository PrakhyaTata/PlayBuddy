//
//  Signupmodel.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/6/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpModel
{
    
    
    var name: String = ""
    var number: String = ""
    
    var username: String = ""
    
    var password: String = ""
    
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    
    func isValidPhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluateWithObject(value)
        return result
    }
    
}
