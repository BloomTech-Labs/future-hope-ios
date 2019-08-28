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

	private static let db = Firestore.firestore()
	
	
	
	func fetchUser(uuid: String, completion: @escaping (Error?) -> ()) {
		let doc = FireStoreController.db.collection(FireStoreController.users).document(uuid)
		doc.getDocument { document, error in
			if let error = error {
				NSLog("Error fetching user from firestore: \(error)")
			}
			
			if let doc = document, doc.exists {
				guard let data  = doc.data() as? [String: Any] else { return }
				print(data)
			}
			
		}
	
	}
	
	
	
}
