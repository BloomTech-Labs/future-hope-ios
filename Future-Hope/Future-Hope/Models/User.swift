//
//  User.swift
//  Future-Hope
//
//  Created by Hector Steven on 8/20/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

enum UserType {
	case mentor
	case teacher
	case admin
}

class User {
	let user_uid: String
	let userType: UserType
	let fullName: String
	let email: String
	let city: String
	let stateOrProvince: String
	let country: String
	let phoneNumber: String
	let aboutme: String
	
	init(user_uid: String, userType: UserType, fullName: String, email: String,
		 city: String, stateOrProvince: String, country: String, phoneNumber: String,
		aboutme: String) {
		self.user_uid = user_uid
		self.userType = userType
		self.fullName = fullName
		self.email = email
		self.city = city
		self.stateOrProvince = stateOrProvince
		self.country = country
		self.phoneNumber = phoneNumber
		self.aboutme = aboutme
	}
	
	var toDictionary: [String: Any]{
		return [
			"usser_uid": user_uid,
			"userType": userType == .mentor ? "mentor" : "teacher" ,
			"fullname": fullName,
			"email": email,
			"city": city,
			"stateOrProvince": stateOrProvince,
			"country": country,
			"phoneNumber": phoneNumber,
			"aboutme": aboutme
		]
	}
	
	
}
