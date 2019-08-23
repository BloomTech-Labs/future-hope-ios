//
//  ModelsController.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/21/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import Firebase


class ModelsController {
	private (set) var user: User?
	
	
	func fetchUserData() {
		guard let currentUser = Auth.auth().currentUser else { return }
		
		let name = currentUser.displayName
		let email  = currentUser.email
		
		
		
		let phoneNumber= currentUser.phoneNumber
		
	}
	
}
