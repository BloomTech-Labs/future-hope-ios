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

	var currentAuthUser: User?
	
	@IBOutlet var fullNameTextField: MDCTextField!
	@IBOutlet var emailTextFields: MDCTextField!
	@IBOutlet var citiTextField: MDCTextField!
	@IBOutlet var stateOrProvinceTextField: MDCTextField!
	@IBOutlet var countryTextField: MDCTextField!
	@IBOutlet var phoneNumberTextField: MDCTextField!
	@IBOutlet var aboutmeTextView: UITextView!
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
		currentAuthUser = ApplicationController().fetchCurrentAuthenticatedUser()
		
		let displayName = currentAuthUser?.displayName
		let email  = currentAuthUser?.email
		let phoneNumber = currentAuthUser?.phoneNumber
		
		
		fullNameTextField?.text = displayName
		emailTextFields?.text = email
		phoneNumberTextField?.text = phoneNumber
	}
	
	
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let citi = citiTextField.text,
			let stateOrProvince = stateOrProvinceTextField.text,
			let country = countryTextField.text,
			let phoneNumber = phoneNumberTextField.text,
			let aboutme = aboutmeTextView.text,
			let	uid = currentAuthUser?.uid,
			let url = currentAuthUser?.photoURL	else  { return }
		
		let userType: UserType = userTypeSegmented.selectedSegmentIndex == 0 ? .mentor : .teacher
		
		if checkTextIsEmpty(fullName: fullName, email: email, citi: citi, stateOrProvince: stateOrProvince,
							country: country, phoneNumber: phoneNumber, aboutMe: aboutme){
			let ac = ApplicationController().simpleActionSheetAllert(with: "Your Text field is empty", message: nil)
			present(ac, animated: true)
			return
		}
		
		
		let signedInUser = CurrentUser(aboutMe: aboutme, awaitingApproval: true,
									   city: citi, country: country, email: email,
									   fullName: fullName, phoneNumber: phoneNumber,
									   photoUrl: url, stateProvince: stateOrProvince,
									   uid: uid, userType: userType)
		
//
//		FireStoreController().addUserToFireStore(with: signedInUser) { error in
//			if let error = error {
//				let ac = ApplicationController().simpleActionSheetAllert(with: "Network Error", message: "Please Try Again 🧐")
//				self.present(ac, animated: true)
//				NSLog("Error adding user to firestore: \(error)")
//				return
//			}
		
			self.gooToMainView()
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
		guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? UINavigationController else {
			print("homeVC was not found!")
			return
		}
		view.window?.rootViewController = homeVC
		view.window?.makeKeyAndVisible()
	}
}
