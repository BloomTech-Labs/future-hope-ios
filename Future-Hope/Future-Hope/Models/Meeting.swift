//
//  Meeting.swift
//  Future-Hope
//
//  Created by SL Hector Villasano on 9/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation
import UIKit

class Meeting {
    
    let id: String
    let participantNames: [String]
    let participantUIDs: [String]
    let start: Date
    let title: String
    
    
    init(id: String, participantNames: [String], participantUIDs: [String], start: Date, title: String) {
        self.id = id
        self.participantNames = participantNames
        self.participantUIDs = participantUIDs
        self.start = start
        self.title = title
    }
    
    convenience init? (dictionary: [String: Any]) {
        
       // print(dictionary)
        
        let id = dictionary["id"] as? String ?? ""
        let title = dictionary["title"] as? String ?? ""
        
        // error with timestamp
        if let startDouble = dictionary["start"] as? Double {
            let start = Date(timeIntervalSince1970: startDouble / 1000)
            print(start)
            let componenets = Calendar.current.dateComponents([.year, .day, .hour, .minute], from: start)
            
            print("\(componenets.year) - \(componenets.day) - \(String(describing: componenets.hour)) - \(componenets.minute)")
        }


        let participantNames = dictionary["participantNames"] as? [String] ?? []
        let participantUIDs = dictionary["participantUIDs"] as? [String] ?? []
        
        
        //print("id: \(id) - title: \(title) - participantNames: \(participantNames[0]) - participantUIDs: \(participantUIDs[0])")
        self.init(id:id, participantNames: participantNames, participantUIDs: participantUIDs, start: Date(), title: title)
        
    }
}
