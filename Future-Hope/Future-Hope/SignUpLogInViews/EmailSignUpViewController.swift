//
//  EmailSignUpViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

import Firebase


import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

class EmailSignUpViewController: UIViewController {

	
	@IBOutlet var fullNameTextField: MDCTextField!
	@IBOutlet var emailTextFields: MDCTextField!
	@IBOutlet var passwordTextField: MDCTextField!
	@IBOutlet var confirmPasswordTextField: MDCTextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let password = passwordTextField.text,
			let confirmPassword = confirmPasswordTextField.text else { return }
		
		
		if password != confirmPassword {
			//Throw action shee error
			
			return
		}
		
		
		Auth.auth().signIn(withEmail: email, password: password) { _, error in
			if let error = error {
				//Throw  action sheet error
				NSLog("Error with email/password signIn: \(error)")
				return
			}
			
			// send user data to firestore
			
			print("\(fullName) - \(email) - \(password)")
			
			//segue to app
			
		}
	}
	
	@IBAction func cancelButtonPressed(_ sender: MDCButton) {
		navigationController?.popViewController(animated: true)
	}
}
