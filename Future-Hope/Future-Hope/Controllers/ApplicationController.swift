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
import GoogleSignIn

class ApplicationController {
	
	private (set) var currentlyLogedInUser: CurrentUser?

    private (set) var meetings: [Meeting] = []
    
    private (set) var allUsers: [CurrentUser] = []
    
    
    init() {
        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        print("here1")
        FireStoreController().fetchAllUsers { allUsers, error in
            if let error = error {
                NSLog("Error  \(error)")
                return
            }
            
            guard let allUsers = allUsers else { return }
            
            // fetch all image data
            
            for user in allUsers {
                
                if let url = user.photoUrl {
                    self.fetchUserImage(with: url, completion: { data, error in
                        if let error = error {
                            NSLog("Error fetching image: \(error)")
                            return
                        }
                        
                        // This is Bad Practice! Implement Cache and implement operations!!
                        
                        guard let data = data else { return }
                        user.imageData = data
                        
                    })
                }
                
                
            }
            
            
            
            
            self.allUsers = allUsers

        }
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

// MARK: CurrentUser Setup
extension ApplicationController {

	// set current user and fetch image
	func setCurrentlyLogedInUser(with user: CurrentUser) {
		currentlyLogedInUser = user
		if let url = user.photoUrl {
			fetchUserImage(with: url) { data, error in
                
				if let error = error {
					print(error)
				}
                
				guard let data  =  data,
                    let currentlyLogedInUser = self.currentlyLogedInUser else { return }
                
                DispatchQueue.main.async {
                    currentlyLogedInUser.imageData = data
                }
			}
		}
	}
	// fetch image with url
	func fetchUserImage(with url: URL, completion: @escaping (Data?, Error?) ->()) {
		URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error{
				NSLog("Error fetching image: \(error)")
				completion(nil, error)
				return
			}
            
			guard let data = data else { return }
			completion(data, nil)
		}.resume()
	}
}


// MARK: Fireabse Auth
extension ApplicationController {

	
	/// Signout with Google credentials
	func signOut(completion: @escaping (Error?) -> Void) {
		let fireAuth = Auth.auth()
		do{
			try fireAuth.signOut()
			completion(nil)
		}catch {
			completion(error)
		}
	}

//    private func gidSignOut() {
//        GIDSignIn.sharedInstance().signOut()
//    }
	
	
	/// SignIn With Google credentials
	func signInWithCredentials(credentail: AuthCredential, completion: @escaping (Error?) -> Void) {
		Auth.auth().signIn(with: credentail) { authResult, error in
			if let error = error {
				completion(error)
				return
			}
            
			completion(nil)
		}
	}
	
	/// Will fetch current user that was signed in with email/gmail/Facebook
	func fetchCurrentFireAuthenticatedUser() -> User? {
		guard let currentUser = Auth.auth().currentUser else { return nil }
		return currentUser
	}
}




// MARK: Meetings
extension ApplicationController {
    
    
    
}
