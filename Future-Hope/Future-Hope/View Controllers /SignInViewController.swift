//
//  SignInViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/19/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

// Firebase
import Firebase
import FirebaseAuth
import GoogleSignIn

// Material
import MaterialComponents.MaterialTextFields

class SignInViewController: UIViewController{
	
	@IBOutlet var emailTextField: MDCTextField!
	@IBOutlet var passwordTextField: MDCTextField!
	
	var handle: AuthStateDidChangeListenerHandle?
	
	deinit {
		if let handle = handle {
			Auth.auth().removeStateDidChangeListener(handle)
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		GIDSignIn.sharedInstance()?.presentingViewController = self
		
		handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
			if let user = user {
				print(user)
				
				// segue into app
			}
			
		})
		
		
    }

	@IBAction func logInButtonPressed(_ sender: UIButton) {
		print("logged in with email/password")
	
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
    }
	

}

