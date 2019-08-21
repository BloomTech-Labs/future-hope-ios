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
	
	// test cred
	// One100?!
	
	
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		
		
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let password = passwordTextField.text,
			let confirmPassword = confirmPasswordTextField.text else { return }
		
		
		if fullName.isEmpty {
			let alertController = ApplicationController().simpleActionSheetAllert(with: "full name is empty", message: nil)
			present(alertController, animated: true)
			return
		}
		
		if password != confirmPassword {
			let alertController = ApplicationController().simpleActionSheetAllert(with: "passwords do not match", message: nil)
			present(alertController, animated: true)
			return
		}
		
		if !passwordIsSafe(with: password) {
			let alertController = ApplicationController().simpleActionSheetAllert(with: "please use a safe password", message: "password must be 6 characters")
			present(alertController, animated: true)
			return
		}
		
		
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				
				print("Error with email/password signIn: \(error) \n authResult: \(authResult.debugDescription) ")
				let alertController = ApplicationController().simpleActionSheetAllert(with: "Error with Sign Up", message: "Please Try Again!")
				self.present(alertController, animated: true)
				
				return
			}
			
			print("\(fullName) - \(email) - \(password)")
			
			// MARK: send user data to firestore and new view
			// MARK: segue to app
			
		}
	}
	
	@IBAction func cancelButtonPressed(_ sender: MDCButton) {
		navigationController?.popViewController(animated: true)
	}
	
	
	private func passwordIsSafe(with password: String) -> Bool {
		
		// Mark: Check for valid password
		
		return true
	}
}
