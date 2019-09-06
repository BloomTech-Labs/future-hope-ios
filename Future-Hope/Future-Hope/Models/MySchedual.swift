//
//  MySchedual.swift
//  Future-Hope
//
//  Created by Hector Steven on 9/5/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class MySchedual {
	let id: String
	let title: String
	let start: Date
	let participantName: String
	let participantUid: UUID
	let participant: CurrentUser
	
	init(id: String, title: String, start: Date, participantName: String, participantUid: UUID, participant: CurrentUser) {
		self.id = id
		self.title = title
		self.start = start
		self.participantName = participantName
		self.participantUid = participantUid
		self.participant = participant
	}
	
}
