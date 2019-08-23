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

class GmailFacebookSignUpViewController: UIViewController {

	@IBOutlet var fullNameTextField: MDCTextField!
	@IBOutlet var emailTextFields: MDCTextField!
	@IBOutlet var citiTextField: MDCTextField!
	@IBOutlet var stateOrProvinceTextField: MDCTextField!
	@IBOutlet var countryTextField: MDCTextField!
	@IBOutlet var phoneNumberTextField: MDCTextField!
	@IBOutlet var aboutTextView: UITextView!
	@IBOutlet var userTypeSegmented: UISegmentedControl!

	

	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(logout))
		
    }
	
	@objc func logout() {
		
		print("here")
		ApplicationController().signOut { error in
			if let error = error {
				// MARK: Throw error
				
				NSLog("Error Signing Out: \(error)")
				return
			}
		}
		dismiss(animated: true, completion: nil)
//		navigationController?.dismiss(animated: true, completion: nil)
	}
	
	
	
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let citi = citiTextField.text,
			let stateOrProvince = stateOrProvinceTextField.text,
			let country = countryTextField.text,
			let phoneNumber = phoneNumberTextField.text,
			let aboutme = aboutTextView.text else { return }
		
		if checkTextIsEmpty(fullName: fullName, email: email, citi: citi, stateOrProvince: stateOrProvince, country: country, phoneNumber: phoneNumber, aboutMe: aboutme){
			let ac = ApplicationController().simpleActionSheetAllert(with: "Your Text field is empty", message: nil)
			present(ac, animated: true)
			return
		}
		print("submit")

//		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//			if let error = error {
//
//				NSLog("Error with Auth Sign In email/password: \(error)\n With authResult: \(authResult.debugDescription)")
//				let alertController = ApplicationController().simpleActionSheetAllert(with: "Error Loging In with email/password with Sign Up", message: "Please Try Again!")
//				self.present(alertController, animated: true)
//
//				return
//			}
		
//			print("\(fullName) - \(email) - \(password)")
			// MARK: Save to User Defaults
			// MARK: send user data to firestore and new view
			// MARK: segue to app
			
//		}
	}

	
}

extension GmailFacebookSignUpViewController{
	
	private func checkTextIsEmpty(fullName: String, email: String, citi: String, stateOrProvince: String, country: String, phoneNumber: String, aboutMe: String) -> Bool{
		return fullName.isEmpty || email.isEmpty || citi.isEmpty || stateOrProvince.isEmpty || country.isEmpty || phoneNumber.isEmpty || aboutMe.isEmpty
	}
	
	private func passwordIsSafe(with password: String) -> Bool {
		// Mark: Check for valid passwor
		if password.count < 6 {
			return  false
		}
		return true
	}
	
	private func gooToMainView() {
//		guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? ViewController else {
//			print("homeVC was not found!")
//			return
//		}
//		view.window?.rootViewController = homeVC
//		view.window?.makeKeyAndVisible()
	}
}
