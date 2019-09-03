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

	var currentAuthUser: CurrentUser?
	
	@IBOutlet var fullNameTextField: MDCTextField!
	@IBOutlet var emailTextFields: MDCTextField!
	@IBOutlet var citiTextField: MDCTextField!
	@IBOutlet var stateOrProvinceTextField: MDCTextField!
	@IBOutlet var countryTextField: MDCTextField!
	@IBOutlet var phoneNumberTextField: MDCTextField!
	@IBOutlet var aboutmeTextView: UITextView!
	@IBOutlet var userTypeSegmented: UISegmentedControl!

	@IBOutlet var passwordTextField: MDCTextField!
	@IBOutlet var confirmPasswordTextView: MDCTextField!
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
		 guard let currentAuthUser = currentAuthUser else { return }
		fullNameTextField?.text = currentAuthUser.fullName
		emailTextFields?.text = currentAuthUser.email
		citiTextField?.text = currentAuthUser.city
		stateOrProvinceTextField?.text = currentAuthUser.stateProvince
		countryTextField?.text = currentAuthUser.country
		aboutmeTextView?.text = currentAuthUser.aboutMe
		userTypeSegmented.selectedSegmentIndex = currentAuthUser.userType! == .mentor ? 0 :  1
		phoneNumberTextField?.text = currentAuthUser.phoneNumber
	}
	
	// User is trying to update their user information on firestore
	@IBAction func submitButtonPressed(_ sender: MDCButton) {
		print("here")
		
		guard let fullName = fullNameTextField.text,
			let email = emailTextFields.text,
			let citi = citiTextField.text,
			let stateOrProvince = stateOrProvinceTextField.text,
			let country = countryTextField.text,
			let phoneNumber = phoneNumberTextField.text,
			let aboutme = aboutmeTextView.text else {
				// found nothing
				let ac = ApplicationController().simpleActionSheetAllert(with: "Please feel in all areas", message: nil)
				present(ac, animated: true)
				return
		}
		
		// get user Type
		
		let usertype: UserType = userTypeSegmented.selectedSegmentIndex == 0 ? .mentor : .teacher
		
		
		// check if signed in with gmail
		if let	uid = currentAuthUser?.uid, let url = currentAuthUser?.photoUrl {
			if checkTextIsEmpty(fullName: fullName, email: email, citi: citi, stateOrProvince: stateOrProvince, country: country, phoneNumber: phoneNumber, aboutMe: aboutme){
				let ac = ApplicationController().simpleActionSheetAllert(with: "Your Text field is empty", message: nil)
				present(ac, animated: true)
				return
			}
			
			let signedInUser = CurrentUser(aboutMe: aboutme, awaitingApproval: true, city: citi, country: country, email: email, fullName: fullName, phoneNumber: phoneNumber, photoUrl: url, stateProvince: stateOrProvince, uid: uid, userType: usertype)
			addUserToFireBase(with: signedInUser)
			
		}else {
			let signedInUser = CurrentUser(aboutMe: aboutme, awaitingApproval: true, city: citi, country: country, email: email, fullName: fullName, phoneNumber: phoneNumber, photoUrl: nil, stateProvince: stateOrProvince, uid: UUID().uuidString, userType: usertype)
			self.firebaseEmailSignUp(with: signedInUser)
		}
	}
	
	private func addUserToFireBase(with user: CurrentUser) {
		FireStoreController().addUserToFireStore(with: user) { error in
			if let error = error {
				let ac = ApplicationController().simpleActionSheetAllert(with: "Network Error", message: "Please Try Again 🧐")
				self.present(ac, animated: true)
				NSLog("Error adding user to firestore: \(error)")
				return
			}
			self.dismiss(animated: true)
		}
	}
		
	private func firebaseEmailSignUp(with user: CurrentUser) {
		//check that passwords match
		//log in with fireAuth
		//send data to fire store
		print("firebase email Sign up")
	}
	
	@IBAction func cancelButtonPressed(_ sender: UIButton) {
		dismiss(animated: true)
		navigationController?.popViewController(animated: true)
	}
}


// MARK : Check TextViews for errors

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
}
