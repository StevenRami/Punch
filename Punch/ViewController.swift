//
//  ViewController.swift
//  Punch
//
//  Created by Steven Ramirez on 8/11/18.
//  Copyright © 2018 Steven Ramirez. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    

}

