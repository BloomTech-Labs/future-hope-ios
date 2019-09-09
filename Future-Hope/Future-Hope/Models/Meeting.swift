//
//  Meeting.swift
//  Future-Hope
//
//  Created by SL Hector Villasano on 9/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation


class Meeting {
    let meetingUid: String
    let participantNames: [String]
    let participantUids: [String]
    let start: Date
    let title: String
    
    init(meetingUid: String, participantNames: [String], participantUids: [String], start: Date, title: String) {
        self.meetingUid = meetingUid
        self.participantNames = participantNames
        self.participantUids = participantUids
        self.start = start
        self.title = title
    }
    
    
}
