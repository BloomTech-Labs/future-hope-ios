//
//  MySchedual.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class MySchedual {
	
	let title: String
	let start: String
	let participantUid: String
	let participant: CurrentUser
	
	
	init(title: String, start: String, participantUid: String, participant: CurrentUser) {
		self.title = title
		self.start = start
		self.participantUid = participantUid
		self.participant = participant
	}
	
}
