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
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import MaterialComponents.MaterialTextFields

class SignInViewController: UIViewController {
    let futureHopSchoolController = ApplicationController()
	@IBOutlet var emailTextField: MDCTextField!
	@IBOutlet var passwordTextField: MDCTextField!
	var handle: AuthStateDidChangeListenerHandle?
	
	var uid: String?
	
	deinit {
		if let handle = handle {
			Auth.auth().removeStateDidChangeListener(handle)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

	private func setupViews() {
        handleAuthStateDidChange()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
	}
	
	// Will run ones firebase senses a login
	private func handleAuthStateDidChange() {
		handle = Auth.auth().addStateDidChangeListener { _, user in
			if let user = user {
				DispatchQueue.main.async {
					self.uid = user.uid
					self.gooToMainView()
				}
			}
		}
	}
	
	// User is trying to login with email/password
	@IBAction func logInButtonPressed(_ sender: UIButton) {
		guard let email = emailTextField.text,
			let password = passwordTextField.text else { return }
		
		if email.isEmpty || password.isEmpty {
			let ac = self.futureHopSchoolController.simpleActionSheetAllert(with: "Error With email/password", message: "Password/email is empty")
			self.present(ac, animated: true)
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				NSLog("Error with Auth Sign In email/password: \(error)\n With authResult: \(authResult.debugDescription)")
				let ac = self.futureHopSchoolController.simpleActionSheetAllert(with: "Error With email/password", message: "Please try Again!")
				self.present(ac, animated: true)
				return
			}
			self.gooToMainView()
		}
	}
	
	// will take you to the tabbar app
	private func gooToMainView() {
		performSegue(withIdentifier: "SegueToMainApp", sender: self)
	}
		
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SegueToMainApp" {
			guard let vc = segue.destination as? TabBarViewController,
			 let uid = uid else { return }
			vc.uid = uid
			vc.futureHopSchoolController = futureHopSchoolController
		}
	}
	
	
//	private func getCurrentUser(_ uid: String) {
//		//		guard let user = futureHopSchoolController.fetchCurrentFireAuthenticatedUser() else { return }
//
//		//check firebase "user" with uid
//		FireStoreController.db.collection(FireStoreController.users).document(uid).getDocument { document, error in
//			if let error = error {
//				NSLog("Error fetching user from firestore: \(error)")
//				return
//			}
//
//			if let doc = document, doc.exists, let data = doc.data() {
//				if let currentUser = CurrentUser(dictionary: data as [String: Any]) {
////					self.futureHopSchoolController.setCurrentlyLogedInUser(with: currentUser)
//					print("found account")
//				}
//			}else {
//				//				self.createUser(user)
//				print("Create an account")
//			}
//		}
//
//	}
	
	
	
}

// Mark : Facebook Login

extension SignInViewController {
	

//	@IBAction func facebookLogInButtonPressed(_ sender: FBLoginButton) {
//		LoginManager().logIn(permissions: [.publicProfile], viewController: self) { result in
//			switch result {
//			case .success(granted: _, declined: _, token: _):
//				self.firebaseFacebookLogIn()
//			case .failed(let err):
//				print("Failed with: \(err)")
//			case .cancelled:
//				print("Canceled! ")
//			}
//		}
//	}
	
//	private func firebaseFacebookLogIn() {
//		let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
//
//		Auth.auth().signIn(with: credential) { (authResult, error) in
//			if let error = error {
//				NSLog("Error with facebook Auth: \(error) \n authResult: \(authResult.debugDescription)")
//				let ac = ApplicationController().simpleActionSheetAllert(with: "Error With FaceBool LogIn", message: "Please try Again!")
//				self.present(ac, animated: true)
//				return
//			}
//
////			print("FaceBook loggedIn with authResult: \(authResult.debugDescription)")
//			if let user = Auth.auth().currentUser {
//				print("Logged in as: ", user.displayName!)
//			}
//		}
//	}
	
	
}



extension SignInViewController: UITextFieldDelegate {
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		view.endEditing(true)
	}
}
