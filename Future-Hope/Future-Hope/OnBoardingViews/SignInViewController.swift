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

import GoogleSignIn
import FBSDKCoreKit

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
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		GIDSignIn.sharedInstance()?.presentingViewController = self
		
		handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
			if let user = user {
				print(user)
				
				// MARK: segue into app
				
			}
			
		})
		
		
    }

	@IBAction func logInButtonPressed(_ sender: UIButton) {
		print("logged in with email/password")
		guard let email = emailTextField.text,
			let password = passwordTextField.text,
			!email.isEmpty || !password.isEmpty  else {
				let ac = ApplicationController().simpleActionSheetAllert(with: "Error With email/password", message: "Password/email is empty")
				self.present(ac, animated: true)
				return
		}
		
		
		
		Auth.auth().signIn(withEmail: email, password: password) { _, error in
			if let error = error {
				NSLog("Error with Auth Sign In email/password: \(error)")
				
				let ac = ApplicationController().simpleActionSheetAllert(with: "Error With email/password", message: "Please try Again!")
				self.present(ac, animated: true)
			}
			
			// MARK: segue to app
			
		}
		
		
		
	
	}
	
//	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//		if let error = error {
//			print(error.localizedDescription)
//			return
//		}
//
//	}
	
	
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
    }
	

}



extension SignInViewController: UITextFieldDelegate {
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		view.endEditing(true)
	}
	
	
	
	
}
