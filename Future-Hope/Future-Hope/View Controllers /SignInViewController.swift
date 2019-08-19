//
//  SignInViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/19/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class SignInViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
		GIDSignIn.sharedInstance()?.presentingViewController = self
		
    }

	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
    }
	

}

