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
		guard let user = futureHopSchoolController.fetchCurrentFireAuthenticatedUser() else { return }
		
		//check firebase "user" with uid
		FireStoreController.db.collection(FireStoreController.users)
			.document(user.uid).getDocument { document, error in
			if let error = error {
				NSLog("Error fetching user from firestore: \(error)")
			}
				
			if let doc = document, doc.exists, let data = doc.data() {
				if let currentUser = CurrentUser(dictionary: data as [String: Any]) {
					self.futureHopSchoolController.setCurrentlyLogedInUser(with: currentUser)
				}
			}else {
				self.createUser(user)
			}
		}
		
	}
	
	
	
	
	private func createUser(_ user: User) {
		print("Create User: \(user.displayName ?? "")")
	}
}
