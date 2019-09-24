//
//  EditProfileViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/4/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class EditProfileViewController: UIViewController {
	@IBOutlet var editLabel: UILabel!
	@IBOutlet var newEditTextField: MDCTextField!
	var editString: String?
	var currentUser: CurrentUser?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		setupViews()
	}
	
	private func setupViews() {
		guard let editString = editString, let currentUser = currentUser else { return }
		
		editLabel?.text = "\(editString):"
		
		if editString == "name" {
			newEditTextField?.text = currentUser.fullName
		} else if editString == "city" {
			newEditTextField?.text = currentUser.city
		} else if editString == "state" {
			newEditTextField?.text = currentUser.stateProvince
		} else if editString == "phone number" {
			newEditTextField?.text = currentUser.phoneNumber
		} else if editString == "about me" {
			newEditTextField?.text = currentUser.aboutMe
		}
	}
	
	@IBAction func exitButtonPressed(_ sender: Any) {
		dismiss(animated: true)
	}
	
	@IBAction func submitButtonPressed(_ sender: Any) {
		guard let newEditString = newEditTextField.text,
			let currentUser = currentUser,
			let editString = editString else { return }
		
		let newUser = currentUser
		
		if editString == "name" {
			newUser.fullName = newEditString
		} else if editString == "city" {
			newUser.city = newEditString
		} else if editString == "state" {
			newUser.stateProvince = newEditString
		} else if editString == "phone number" {
			newUser.phoneNumber = newEditString
		} else if editString == "about me" {
			newUser.aboutMe = newEditString
		}
		
		// Just updating current user
		FireStoreController().addUser(with: newUser) { error in
			if let error = error {
				print("Error updating firestore: \(error)")
			}
			self.dismiss(animated: true)
			print("success!!!!!!!")
		}
	}
}
