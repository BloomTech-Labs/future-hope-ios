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
        FireStoreController().fetchAllUsersFromFireStore { allUsers, error in
            if let error = error {
                NSLog("Error  \(error)")
                return
            }
            
            guard let allUsers = allUsers else { return }
            self.allUsers = allUsers
            
        }
        
        
    }
    
    
	
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
	
    
    func fetchAllUsersFromMeetings(){
        
        
    }
    
    
    
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
	
    
    func fetchMyMeetings(completion: @escaping (Error?) -> ()) {
        guard let user = currentlyLogedInUser else { return }
        FireStoreController().fetchMeetingsFromFirestore{ allMeetings, error in
            if let error = error {
                NSLog("Error fetching my meetings: \(error)")
                completion(error)
                return
            }
            
            var newMeetings: [Meeting] = []
            
            guard let allMettings = allMeetings else { return }

            for aMeeting in allMettings {
                for participantUID in aMeeting.participantUIDs {
                    if participantUID == user.uid {
                        newMeetings.append(aMeeting)
                    }
                }
            }
            
            self.meetings = newMeetings
            
            completion(nil)
        }
        
        
    }
    
    
    
}


// MARK: Fireabse Auth

extension ApplicationController {

	
	/// Signout with Google credentials
	func signOut(completion: @escaping (Error?) -> Void) {
		let fireAuth = Auth.auth()
		do{
			try fireAuth.signOut()
			//gidSignOut()
			NSLog("SignOut Success!")
			completion(nil)
		}catch {
			NSLog("Error signing out with :\(error)")
			completion(error)
		}
	}

	private func gidSignOut() {
		GIDSignIn.sharedInstance().signOut()
	}
	
	
	/// SignIn With Google credentials
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
	
	/// Will fetch current user that was signed in with email/gmail/Facebook
	func fetchCurrentFireAuthenticatedUser() -> User? {
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
