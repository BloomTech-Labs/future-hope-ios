//
//  TabBarViewController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/29/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import FirebaseAuth


protocol FutureHopSchoolControllerProtocol: AnyObject {
	var futureHopSchoolController: ApplicationController? { set get }
}


class TabBarViewController: UITabBarController {
	
	let futureHopSchoolController = ApplicationController()
	var currentUser: CurrentUser?
	var uid: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		getCurrentUser()
		for childVC in children {
			if let vc = childVC as? FutureHopSchoolControllerProtocol {
				vc.futureHopSchoolController = futureHopSchoolController
			}
		}
    }
	
	
	private func getCurrentUser() {
		guard let uid = uid else { return }
		FireStoreController.db.collection(FireStoreController.users).document(uid).getDocument { document, error in
			if let error = error {
				NSLog("Error fetching user from firestore: \(error)")
				return
			}
			
			print("Found!!!!!")
			if let doc = document, doc.exists, let data = doc.data() {
				if let currentUser = CurrentUser(dictionary: data as [String: Any]) {
					self.futureHopSchoolController.setCurrentlyLogedInUser(with: currentUser)
					print("found account")
				}else {
					print("Error getting data from fire store!")
				}
			}else {
//				self.createUser(user)
				print("Create an account")
			}
		}
		
	}
	
	private func createUser(_ user: User) {
		guard let name = user.displayName, let email = user.email, let photoUrl = user.photoURL else { return }
		
		let currentUser = CurrentUser(aboutMe: "", awaitingApproval: true, city: "", country: "", email: email, fullName: name, phoneNumber: "", photoUrl: photoUrl, stateProvince: "", uid: user.uid, userType: .mentor, imageData: nil)
		FireStoreController().addUserToFireStore(with: currentUser) { error in
			if let error = error {
				NSLog("Error adding using to fireStore: \(error)")
				return
			}
			print("User Created in firestore user!")
		}
		
	}
}
