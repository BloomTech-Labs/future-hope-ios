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
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupViews()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		// User tapped backed button. Logout
		
		ApplicationController().signOut { error in
			if let error = error {
				NSLog("Error Signing Out: \(error)")
				return
			}
		}
	}
	
	private func setupViews() {
		guard let currentUser = Auth.auth().currentUser else { return }
		
//		let user_uid = currentUser.uid
		let displayName = currentUser.displayName
		let email  = currentUser.email
		let phoneNumber = currentUser.phoneNumber
		
		fullNameTextField.text = displayName
		emailTextFields.text = email
		phoneNumberTextField.text = phoneNumber
	}
	
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let citi = citiTextField.text,
			let stateOrProvince = stateOrProvinceTextField.text,
			let country = countryTextField.text,
			let phoneNumber = phoneNumberTextField.text,
			let aboutme = aboutTextView.text else { return }
		
		print(userTypeSegmented.selectedSegmentIndex)
		
		if checkTextIsEmpty(fullName: fullName, email: email, citi: citi, stateOrProvince: stateOrProvince, country: country, phoneNumber: phoneNumber, aboutMe: aboutme){
			let ac = ApplicationController().simpleActionSheetAllert(with: "Your Text field is empty", message: nil)
			present(ac, animated: true)
			return
		}
		
		let user = User(user_uid: UUID().uuidString, userType: .mentor, fullName: fullName, email: email, city: citi, stateOrProvince: stateOrProvince, country: country, phoneNumber: phoneNumber, aboutme: aboutme)
		
		// MARK: if User submits send data to firestore
		
		print("sign Up with this user credentials. \(user.email) - \(user.phoneNumber)")
		
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
