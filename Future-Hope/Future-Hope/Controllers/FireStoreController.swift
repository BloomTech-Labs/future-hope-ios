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
