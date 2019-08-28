//
//  ApplicationController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore




class ApplicationController {
	
	
	
	
	
	
}


// MARK: Fireabse Auth Auth

extension ApplicationController {
	func signInWithCredentials(credentail: AuthCredential, completion: @escaping (Error?) -> Void) {
		Auth.auth().signIn(with: credentail) { authResult, error in
			if let error = error {
				NSLog("\t->>>>>>>>> Error with Auth sign in with credential: \(error)\nauthResult\(authResult.debugDescription)")
				completion(error)
				return
			}
		
			NSLog("Auth comple with: \(authResult.debugDescription)")
			completion(nil)
		}
	}
	
	func signOut(completion: @escaping (Error?) -> Void) {
		
		let fireAuth = Auth.auth()
		do{
			try fireAuth.signOut()
			NSLog("SignOut Success!")
			completion(nil)
		}catch {
			NSLog("Error signing out with :\(error)")
			completion(error)
		}
	}
	
	// Will fetch current user that was signed in with email/gmail/Facebook
	func fetchCurrentAuthenticatedUser() -> User? {
		guard let currentUser = Auth.auth().currentUser else { return nil }
		return currentUser
	}
	
	
}


// MARK: AlertControllers

extension ApplicationController {
	
	
	func simpleActionSheetAllert(with title: String, message: String?) -> UIAlertController{
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
		
		return ac
	}
}
