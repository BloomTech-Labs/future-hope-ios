//
//  FireStoreController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/27/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import Firebase



struct FireStoreController {
	static let users = "users"

	static let db = Firestore.firestore()
	
	
	/// Fetch user with uuid from firestore
//	func fetchUserFromFireStore(uuid: String, completion: @escaping (CurrentUser?, Error?) -> ()) {
//		FireStoreController.db.collection(FireStoreController.users)
//			.document(uuid).getDocument { document, error in
//			if let error = error {
//				NSLog("Error fetching user from firestore: \(error)")
//				completion(nil, error)
//				return
//			}
//			
//			if let doc = document, doc.exists {
//				guard let data  = doc.data() else { return }
//				let dictionary = data as [String: Any]
//				
//				if let currentUser = CurrentUser(dictionary: dictionary) {
//					completion(currentUser, nil)
//				} else {
//					print("Error parsing!")
//					completion(nil, NSError())
//				}
//				
//			}
//				
//		}
//	}
	
	
	func addUserToFireStore(with user: CurrentUser, completion: @escaping (Error?) -> ()) {
		Firestore.firestore().collection(FireStoreController.users)
			.document(user.uid).setData(user.toDictionary) { error in
				if let error = error {
					NSLog("Error seting data to firestore: \(error)")
					completion(error)
				}
				completion(nil)
		}
	}

}
