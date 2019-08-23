//
//  User.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class User {
	let fullName: String
	let email: String
	let city: String
	let stateOrProvince: String
	let country: String
	let phoneNumber: String
	
	init(fullName: String, email: String, city: String, stateOrProvince: String, Country: String, phoneNumber: String) {
		self.fullName = fullName
		self.email = email
		self.city = city
		self.stateOrProvince = stateOrProvince
		self.country = country
		self.phoneNumber = phoneNumber
	}	
}
