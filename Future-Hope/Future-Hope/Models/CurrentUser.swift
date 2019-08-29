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

class CurrentUser {
	let aboutMe: String
	let awaitingApproval: Bool
	let city: String
	let country: String
	let email: String
	let fullName: String
	let phoneNumber: String
	let photoUrl: URL
	let stateProvince: String
	let uid: String
	let userType: UserType
	
	let imageData: Data?
	
	init(aboutMe: String, awaitingApproval: Bool, city: String, country: String,
		 email: String, fullName: String, phoneNumber: String, photoUrl: URL,
		 stateProvince: String, uid: String, userType: UserType,
		 imageData: Data? = nil
		) {
		self.aboutMe = aboutMe
		self.awaitingApproval = awaitingApproval
		self.city = city
		self.country = country
		self.email = email
		self.fullName = fullName
		self.phoneNumber = phoneNumber
		self.photoUrl = photoUrl
		self.stateProvince = stateProvince
		self.uid = uid
		self.userType = userType
		self.imageData = imageData
	}
	
	convenience init? (dictionary: [String: Any]) {
		let aboutMe  = dictionary["aboutMe"] as! String
		let awaitingApproval = dictionary["awaitingApproval"] as! Bool
		let city = dictionary["city"] as! String
		let country = dictionary["country"] as! String
		let email = dictionary["email"] as! String
		let fullName = dictionary["fullName"] as! String
		let phoneNumber = dictionary["phoneNumber"] as! String
		let photoUrlString = dictionary["photoUrl"] as! String
		let photoUrl = URL(string: photoUrlString)!
		let stateProvince = dictionary["stateProvince"] as! String
		let uid = dictionary["uid"] as! String
		let userType: UserType = (dictionary["userType"] as! String) == "mentor" ?  .mentor : .teacher
		
		self.init(aboutMe: aboutMe, awaitingApproval: awaitingApproval, city: city, country: country,
				  email: email, fullName: fullName, phoneNumber: phoneNumber, photoUrl: photoUrl,
				  stateProvince: stateProvince, uid: uid, userType: userType)
	}

	var toDictionary: [String: Any]{
		return [
			"aboutMe": aboutMe,
			"awaitingApproval": awaitingApproval,
			"city": city,
			"country": country,
			"email": email,
			"fullName": fullName,
			"phoneNumber": phoneNumber,
			"photoUrl": photoUrl.absoluteString,
			"stateProvince": stateProvince,
			"uid": uid,
			"userType": userType == .mentor ? "mentor" : "teacher"
			]
	}
}
